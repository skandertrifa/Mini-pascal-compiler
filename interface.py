# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'interface_compilateur.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

from line_numbers import QCodeEditor


class Ui_Compilateur(object):
    def setupUi(self, CompilateurMiniPascal):
        CompilateurMiniPascal.setObjectName("CompilateurMiniPascal")
        CompilateurMiniPascal.setEnabled(True)
        CompilateurMiniPascal.resize(772, 633)
        self.groupBox = QtWidgets.QGroupBox(CompilateurMiniPascal)
        self.groupBox.setGeometry(QtCore.QRect(140, 150, 461, 71))
        self.groupBox.setObjectName("groupBox")
        self.lineEdit = QtWidgets.QLineEdit(self.groupBox)
        self.lineEdit.setGeometry(QtCore.QRect(10, 30, 341, 20))
        self.lineEdit.setObjectName("lineEdit")
        self.pushButton = QtWidgets.QPushButton(self.groupBox)
        self.pushButton.setGeometry(QtCore.QRect(360, 30, 91, 23))
        self.pushButton.setObjectName("pushButton")
        self.label_5 = QtWidgets.QLabel(self.groupBox)
        self.label_5.setGeometry(QtCore.QRect(10, 80, 101, 16))
        self.label_5.setObjectName("label_5")


        self.plainTextEdit_2 = QCodeEditor(CompilateurMiniPascal)
        self.plainTextEdit_2.setEnabled(True)
        self.plainTextEdit_2.setGeometry(QtCore.QRect(0, 300, 391, 331))
        self.plainTextEdit_2.setPlainText("")

        self.plainTextEdit = QtWidgets.QPlainTextEdit(CompilateurMiniPascal)
        self.plainTextEdit.setEnabled(True)
        self.plainTextEdit.setGeometry(QtCore.QRect(390, 300, 381, 361))
        self.plainTextEdit.setStyleSheet("background-color: rgb(49, 49, 49);\n"
                                         "color: rgb(255, 0, 0);")
        self.plainTextEdit.setPlainText("")
        self.plainTextEdit.setObjectName("plainTextEdit")
        self.label = QtWidgets.QLabel(CompilateurMiniPascal)
        self.label.setGeometry(QtCore.QRect(140, 60, 461, 51))
        self.label.setObjectName("label")
        self.pushButton_2 = QtWidgets.QPushButton(CompilateurMiniPascal)
        self.pushButton_2.setGeometry(QtCore.QRect(300, 230, 161, 51))
        self.pushButton_2.setStyleSheet("background-color: rgb(0, 170, 0);")
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(":/code-coding-compile-512.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.pushButton_2.setIcon(icon)
        self.pushButton_2.setObjectName("pushButton_2")
        self.label_7 = QtWidgets.QLabel(CompilateurMiniPascal)
        self.label_7.setGeometry(QtCore.QRect(100, 280, 121, 16))
        self.label_7.setObjectName("label_7")
        self.label_8 = QtWidgets.QLabel(CompilateurMiniPascal)
        self.label_8.setGeometry(QtCore.QRect(560, 280, 121, 16))
        self.label_8.setObjectName("label_8")
        self.toolButton = QtWidgets.QToolButton(CompilateurMiniPascal)
        self.toolButton.setGeometry(QtCore.QRect(670, 300, 101, 22))
        self.toolButton.setStyleSheet("background-color: rgb(255, 85, 0);")
        self.toolButton.setObjectName("toolButton")

        self.retranslateUi(CompilateurMiniPascal)
        self.toolButton.clicked.connect(self.plainTextEdit.clear)
        QtCore.QMetaObject.connectSlotsByName(CompilateurMiniPascal)

    def retranslateUi(self, CompilateurMiniPascal):
        _translate = QtCore.QCoreApplication.translate
        CompilateurMiniPascal.setWindowTitle(_translate("CompilateurMiniPascal", "Mini Pascal Compilateur"))
        self.groupBox.setTitle(_translate("CompilateurMiniPascal", "Importer le fichier source"))
        self.pushButton.setText(_translate("CompilateurMiniPascal", "Parcourir.."))
        self.label_5.setText(_translate("CompilateurMiniPascal",
                                        "<html><head/><body><p><span style=\" font-weight:600;\">Code Source</span></p><p><br/></p></body></html>"))
        self.label.setText(_translate("CompilateurMiniPascal",
                                      "<html><head/><body><p align=\"center\"><span style=\" font-size:22pt; font-weight:600;\">Mini-Pascal </span></p></body></html>"))
        self.pushButton_2.setText(_translate("CompilateurMiniPascal", "Compiler"))
        self.label_7.setText(_translate("CompilateurMiniPascal",
                                        "<html><head/><body><p><span style=\" font-weight:600;\">Code Source</span></p><p><br/></p></body></html>"))
        self.label_8.setText(_translate("CompilateurMiniPascal",
                                        "<html><head/><body><p><span style=\" font-weight:600;\">Résultats</span></p><p><br/></p></body></html>"))
        self.toolButton.setText(_translate("CompilateurMiniPascal", "CLEAR"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Compilateur = QtWidgets.QDialog()
    ui = Ui_Compilateur()
    ui.setupUi(Compilateur)
    Compilateur.show()
    sys.exit(app.exec_())

