/****************************************************************************
**
** Copyright (C) 2014 Dinu SV.
** (contact: mail@dinusv.com)
** This file is part of Live CV application.
**
** GNU General Public License Usage
** 
** This file may be used under the terms of the GNU General Public License 
** version 3.0 as published by the Free Software Foundation and appearing 
** in the file LICENSE.GPL included in the packaging of this file.  Please 
** review the following information to ensure the GNU General Public License 
** version 3.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.
**
****************************************************************************/

import QtQuick 2.1
import Cv 1.0

TextEdit {
    id : editor

    signal save()
    signal open()
    signal toggleSize()

    signal pageUp()
    signal pageDown()

    focus : false
    font.family: "Courier New"
    font.pixelSize: 13
    color : "#ffffff"

    selectByMouse: true
    mouseSelectionMode: TextEdit.SelectCharacters
    selectionColor: "#3d4856"

    textFormat: TextEdit.PlainText
    text : ""
    wrapMode: TextEdit.NoWrap

    Keys.onPressed: {
        if ( (event.key === Qt.Key_BracketRight && (event.modifiers & Qt.ShiftModifier) ) ||
             (event.key === Qt.Key_BraceRight) ){

            event.accepted = true
            if ( cursorPosition > 4 ){
                var clastpos = cursorPosition
                if( editor.text.substring(cursorPosition - 4, cursorPosition) === "    " ){
                    editor.text = editor.text.slice(0, clastpos - 4) + "}" + editor.text.slice(clastpos)
                    cursorPosition = clastpos - 3
                } else {
                    editor.text = editor.text.slice(0, clastpos) + "}" + editor.text.slice(clastpos)
                    cursorPosition = clastpos + 1
                }
            }
        } else if ( event.key === Qt.Key_S && (event.modifiers & Qt.ControlModifier ) ){
            editor.save()
            event.accepted = true
        } else if ( event.key === Qt.Key_O && (event.modifiers & Qt.ControlModifier ) ) {
            editor.open()
            event.accepted = true
        } else if ( event.key === Qt.Key_E && (event.modifiers & Qt.ControlModifier ) ){
            editor.toggleSize()
            event.accepted = true
        } else if ( event.key === Qt.Key_PageUp ){
            editor.pageUp()
            event.accepted = true
        } else if ( event.key === Qt.Key_PageDown ){
            editor.pageDown()
            event.accepted = true
        } else
            event.accepted = false
    }

    Keys.onReturnPressed: {
        event.accepted = true
        var clastpos = cursorPosition
        var append = ""
        var cpos = cursorPosition - 1
        var bracketSearchEnd = false
        while ( cpos > 0 ){
            if ( !bracketSearchEnd ){
                if ( editor.text.charAt(cpos) !== ' ' ){
                    if ( editor.text.charAt(cpos) === '{' ){
                        append += "    "
                        bracketSearchEnd = true
                    } else {
                        bracketSearchEnd = true
                    }
                }
            }// bracket search
            if ( editor.text.charAt(cpos) === '\n' ){
                ++cpos;
                while( editor.text.charAt(cpos) === '\t' || editor.text.charAt(cpos) === ' ' ){
                    append += editor.text.charAt(cpos)
                    ++cpos
                }
                break;
            }
            --cpos;
        }
        editor.text = editor.text.slice(0, clastpos) + "\n" + append + editor.text.slice(clastpos)
        editor.cursorPosition = clastpos + 1 + append.length
    }
    Keys.onTabPressed: {
        event.accepted = true
        var clastpos = cursorPosition
        editor.text = editor.text.slice(0, clastpos) + "    " + editor.text.slice(clastpos)
        editor.cursorPosition = clastpos + 4
    }


    CodeHandler{
        id : codeH
        Component.onCompleted: {
            codeH.target = parent.textDocument
        }
    }

}
