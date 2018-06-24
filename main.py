# -*- coding: utf-8 -*-
"""
    To God be the Glory. Amen
"""
import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from func.main import Installer

def cleanUp():

    inst.app_running = False

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    inst = Installer()
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty('DirectInstaller', inst)
    engine.load('ui/main.qml')
    engine.quit.connect(app.quit)
    app.aboutToQuit.connect(cleanUp)

    sys.exit(app.exec_())
