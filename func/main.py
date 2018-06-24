# -*- coding: utf-8 -*-
# To God be the Glory
import os
import threading
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from func.dirs import FOLDERS, FROM_MAIN_FOLDER, TO_MAIN_FOLDER, TOTAL_BYTES


class Installer(QObject):


    """
    
    
    # Protocol
    Errors should have the function's name for easy tracing
    eg. Error _check_folders: something went wrong
    """


    def __init__(self):
        QObject.__init__(self)
        self.app_running = True
        self.completed_size = 0

    currentStatusChanged = pyqtSignal(str, arguments=["status"])
    progressChanged = pyqtSignal(int, arguments=["progress"])
    completed = pyqtSignal(str, arguments=["_install"])


    @pyqtSlot()
    def start(self):


        """
        """


        print('we thank God')
        start_thread = threading.Thread(target=self._install)
        start_thread.daemon = True
        start_thread.start()


    def status(self, curr_status):


        """
           This updates the status on the side of the UI
           It is called from the two installing functions with the status
        """


        self.currentStatusChanged.emit(curr_status)


    def progress(self):


        """
        """
        
        percent = (self.completed_size / TOTAL_BYTES) * 100
        print(percent)


        self.progressChanged.emit(percent)


    def _check_folders(self):


        """
            This checks the From-folder to see if the number of folders
            in there is the exact number of folders that we need to
            successfully install DirectX
        """


        contents = os.listdir(FROM_MAIN_FOLDER)

        if len(contents) == 3:
            return True
        else:
            # throw exception,
            # cannot continue
            self.status('Error _check_folders: ' + 'Some required folders are missing ' +
                  'please download a Fresh copy')


    def _install(self):


        """
            Installs the From required directx files into the
            To its folders
        """


        # Installing
        for folder in FOLDERS:
            folder_from = FROM_MAIN_FOLDER + '/' + folder
            folder_to = TO_MAIN_FOLDER + '/' + folder

            # prevent the manifest folder from being read this way
            if folder == "WinSxS":
                # use the _install_winSxS function
                self._install_winSxS()
            # the others can be installed this way
            else:


                # create the folders at a go
                if not os.path.exists(folder_to):
                    os.makedirs(folder_to)
                else:
                    # do nothing
                    pass

                # get the contents
                content = os.listdir(folder_from)

                # loop through each file
                for item in content:

                    if self.app_running:


                        # prevent the folders from being looped
                        if item == 'en-US':
                            # causes some small problem
                            continue
    
                        else:
                            # create each file
                            print(item)
                            with open(folder_from + "/" + item, 'rb') as br:
                                    data = br.read()
                            ### if it exists skip.
                            if not os.path.exists(folder_to + "/" + item):
    
                                with open(folder_to + "/" + item, 'wb') as bf:
                                    stat = "Currently installing file: " + folder_to + "/" + item
                                    self.status(stat)
                                    self.completed_size += len(data)
                                    self.progress()
                                    bf.write(data)
        
                            else:
                                # skip
                                # FIXME
                                # the continue code
                                self.status('Error _install: ' +
                                      folder_to + '/' + item + ' already installed')
                                continue

        stat = 'Installation Complete'
        self.completed.emit(stat)


    def _install_winSxS(self):


        """
            Installation of the contents that should go into the WinSXS folder
        """


        # starting
        from_winSxS_folder = FROM_MAIN_FOLDER + "/" + "WinSxS"
        to_winSxS_folder = TO_MAIN_FOLDER + "/" + "WinSxS"
        
        folders = os.listdir(from_winSxS_folder)
        for folder in folders:
            if folder == 'Manifest':
                # skip
                pass
            else:
                folder_from = from_winSxS_folder + '/' + folder
                folder_to = to_winSxS_folder + '/' + folder

                # create the folders at a go
                if not os.path.exists(folder_to):
                    os.makedirs(folder_to)
                else:
                    # do nothing
                    pass
                
                # read contents
                # get the contents
                content = os.listdir(folder_from)

                # loop through each file
                for item in content:

                    if self.app_running:


                        # create each file
                        print(item)
                        with open(folder_from + "/" + item, 'rb') as br:
                                data = br.read()
                        ### if it exists skip.
                        if not os.path.exists(folder_to + "/" + item):
    
                            with open(folder_to + "/" + item, 'wb') as bf:
    
                                stat = "Currently installing file: " + folder_to + "/" + item
                                self.status(stat)
                                self.completed_size += len(data)
                                self.progress()
                                bf.write(data)
    
                        else:
                            # skip
                            # FIXME
                            # the continue code
                            self.status('Error _install: ' + 
                                  folder_to + '/' + item + ' already installed')
                            continue
