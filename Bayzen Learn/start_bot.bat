@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title Bayzen Study Bot
color 07

echo ========================================
echo    Bayzen Study Bot - Запуск
echo ========================================
echo.

REM Проверка наличия Python (проверяем py и python)
set PYTHON_CMD=
py --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=py
    echo [INFO] Python найден (команда: py)
    goto :python_found
)

python --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=python
    echo [INFO] Python найден (команда: python)
    goto :python_found
)

echo [ОШИБКА] Python не найден!
echo Установите Python с https://www.python.org/
pause
exit /b 1

:python_found
REM Определяем команду pip
set PIP_CMD=!PYTHON_CMD! -m pip
!PYTHON_CMD! -m pip --version >nul 2>&1
if not %errorlevel% equ 0 (
    set PIP_CMD=pip
)

echo.
REM Проверка наличия зависимостей
echo [INFO] Проверка зависимостей...
!PIP_CMD! show python-telegram-bot >nul 2>&1
if not %errorlevel% equ 0 (
    echo [INFO] Установка зависимостей...
    !PIP_CMD! install -r requirements.txt
    if not %errorlevel% equ 0 (
        echo [ОШИБКА] Не удалось установить зависимости!
        pause
        exit /b 1
    )
    echo [OK] Зависимости установлены
) else (
    echo [OK] Зависимости уже установлены
)

echo.
echo ========================================
echo    Запуск бота...
echo ========================================
echo.

REM Запуск бота
!PYTHON_CMD! bot.py

REM Если бот завершился с ошибкой
if errorlevel 1 (
    echo.
    echo [ОШИБКА] Бот завершился с ошибкой!
    pause
)

