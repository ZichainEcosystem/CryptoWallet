# -*- mode: python -*-
import os
import site

block_cipher = None

site_packages_dir = site.getsitepackages()[1]
qml_dir = os.path.join(site_packages_dir, 'PyQt5', 'Qt', 'qml')
qt_dir = os.path.join(site_packages_dir, 'PyQt5')
qt_dll_dir = os.path.join(site_packages_dir, 'PyQt5', 'Qt', 'bin')
coincurve_dir = os.path.join(site_packages_dir, 'coincurve')
crypto_dir = os.path.join(site_packages_dir, 'Crypto', 'Hash')
bitcoin_dir = os.path.join(site_packages_dir, 'bitcoin')

added_files = [
         ( 'qmls/', 'qmls/' ),
         ( 'icons/', 'icons//' ),
         ('english.txt', '.'),
         (os.path.join(qt_dll_dir, 'Qt5Charts.dll'), '.'),
         (os.path.join(qml_dir, 'QtGraphicalEffects'), 'PyQt5/Qt/qml/QtGraphicalEffects'),
		 (os.path.join(qt_dir, 'sip.pyd'), 'PyQt5'),
         (os.path.join(qml_dir, 'QtCharts'), 'PyQt5/Qt/qml/QtCharts'),
         (os.path.join(bitcoin_dir, 'english.txt'), 'bitcoin'),
         ]

a = Analysis(['main.py'],
             pathex=['C:\\Users\\akhoroshev\\PycharmProjects\\Wallet'],
             binaries=[],
             datas=added_files,
             hiddenimports=[],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          exclude_binaries=True,
          name='main',
          debug=False,
          strip=False,
          upx=True,
          console=False )
coll = COLLECT(exe,
               a.binaries,
               a.zipfiles,
               a.datas,
               strip=False,
               upx=True,
               name='main')
