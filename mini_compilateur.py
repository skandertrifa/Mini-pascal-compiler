import datetime
import os
import subprocess
import time

from PyQt5 import QtCore, QtWidgets
from PyQt5.QtWidgets import QFileDialog
import sys
import interface


class Window(QtWidgets.QDialog, interface.Ui_Compilateur):
    def __init__(self, parent=None):
        super(Window, self).__init__(parent)
        self.Dialog = self.setupUi(self)
        self.file_name = ''
        self.pushButton.clicked.connect(self.open_file)
        #self.pushButton_3.clicked.connect(self.file_save)
        #self.pushButton_4.clicked.connect(self.save)
        self.pushButton_2.clicked.connect(self.compile_source_code)

    def open_file(self):
        file_name, selected_filter = QFileDialog.getOpenFileName(self.Dialog, 'Select a File')
        if file_name:
            _translate = QtCore.QCoreApplication.translate
            self.lineEdit.setText(_translate("Dialog", file_name))
            self.file_name = self.lineEdit.text()
            with open(file_name, "r") as f:
                self.plainTextEdit_2.setPlainText(f.read())
            self.plainTextEdit.clear()

    def file_save(self):
        file_name, selected_filter = QFileDialog.getSaveFileName(self.Dialog, 'Save File', 'log', '*.txt')
        _translate = QtCore.QCoreApplication.translate
        #self.lineEdit_3.setText(_translate("Dialog", file_name))

    def save(self):
        name = self.lineEdit_3.text()
        trace = self.plainTextEdit.toPlainText()
        with open(name, 'w') as f:
            f.write(trace)
        sys.exit()

    def compile_source_code(self):
        with open("tmp.txt", "w") as code_file:
            code_file.write(self.plainTextEdit_2.toPlainText())
        with open("tmp.txt", "r") as file:
            p = subprocess.Popen('compilateur.exe', stdin=file, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            out, err = p.communicate()
            print(out)
            print(err)

        now = datetime.datetime.now()
        current_time = now.strftime("%H:%M:%S %d-%m-%Y")
        self.plainTextEdit.appendPlainText("Logged at " + current_time)

        if err:
            self.plainTextEdit.appendPlainText(err.decode("utf-8"))
            self.plainTextEdit.appendPlainText("*********************************")
        else:
            self.plainTextEdit.setStyleSheet("background-color: rgb(49, 49, 49);\n""color: rgb(0, 255, 0);")
            self.plainTextEdit.appendPlainText('Successfully compiled :)')
            self.plainTextEdit.appendPlainText("*********************************")


def main():
    # Open the interface and collect data
    app = QtWidgets.QApplication(sys.argv)
    w = Window()
    w.show()
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()