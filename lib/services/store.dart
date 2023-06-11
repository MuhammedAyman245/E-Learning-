import 'dart:io';
import 'package:e_learning_app/models/assignments.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/models/lec.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_learning_app/models/quiz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Store {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  addLecture(Lectures lecture) async {
    try {
      await _firestore.collection('Lectures').add({
        subName: lecture.sub,
        lecName: lecture.name,
        lecDuration: lecture.duration,
        lecPath: lecture.link
      });
    } catch (e) {
      print(e);
    }
  }

  loadLec() {
    return _firestore.collection('Lectures').snapshots();
  }

  Stream<QuerySnapshot> loadLecture() {
    return _firestore.collection('Lectures').snapshots();
  }

  deleteLec(documentId) {
    return _firestore.collection('Lectures').doc(documentId).delete();
  }

  editLec(documentId, data) {
    return _firestore.collection('Lectures').doc(documentId).update(data);
  }

  addQuiz(QuizData quiz) async {
    try {
      await _firestore.collection('Quizes').add({
        subName: quiz.sub,
        quizNumber: quiz.quizNumber,
        quizQuestion: quiz.question,
        quizAnswer: quiz.answer,
        firstChoose: quiz.firstChoose,
        secondChoose: quiz.secondChoose,
        thirdChoose: quiz.thirdChoose,
        numofQues: quiz.numofQues,
      });
      print('done');
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> loadQuiz() {
    return _firestore.collection('Quizes').snapshots();
  }

  editQuiz(documentId, data) {
    return _firestore.collection('Quizes').doc(documentId).update(data);
  }

  addAssignment(Assignment assignment) async {
    try {
      await _firestore.collection('Assignment').add({
        subName: assignment.sub,
        assName: assignment.assName,
      });
    } catch (e) {
      print(e);
    }
  }

  editAssignment(documentId, data) {
    return _firestore.collection('Assignment').doc(documentId).update(data);
  }

  deleteAssignment(documentId) {
    return _firestore.collection('Assignment').doc(documentId).delete();
  }

  Stream<QuerySnapshot> loadAssignments() {
    return _firestore.collection('Assignment').snapshots();
  }

  uploadImage(File file, String bucket, String name, String num) async {
//    String filename = basename(file.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      Reference ref = storage.ref().child("<$bucket>/<$name>/$num");
      UploadTask task = ref.putFile(file);
      TaskSnapshot url = await task;
      String downloaded = await url.ref.getDownloadURL();
      return downloaded;
    } catch (e) {
      print(e);
    }
  }

  loadImage(String type, String sub, String name) async {
    try {
      final ref = FirebaseStorage.instance.ref().child("<$type>/<$sub>/$name");
      String url = await ref.getDownloadURL();
      //  print(url);
      return url;
    } catch (e) {
      print(e);
    }
  }
}
