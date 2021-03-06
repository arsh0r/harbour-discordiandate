/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../fnord.js" as Fnord

Page {
    id: page
    property var usrDate: new Date() //date that the user has picked

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Language")
                onClicked: pageStack.push(Qt.resolvedUrl("Language.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            Component.onCompleted: {
                ddate.text = Fnord.discordianDate(usrDate)
                dtflux.text = Fnord.daysuntilcelebrate(usrDate)
            }

            PageHeader {
                id: header
                title: qsTr("Discordian Date")
            }
            Button { //Asks user to pick a date
                id: button
                text: usrDate.toDateString()
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", {
                        date: usrDate
                    });
                    dialog.accepted.connect(function() {
                        usrDate.setFullYear(dialog.year)
                        usrDate.setMonth(dialog.month-1)
                        usrDate.setDate(dialog.day)

                        button.text = usrDate.toDateString()
                        ddate.text = Fnord.discordianDate(usrDate)
                        dtflux.text = Fnord.daysuntilcelebrate(usrDate)
                    })
                }
            }
            Label {
                id: ddate
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }

                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeExtraLarge
                color: Theme.secondaryHighlightColor
            }
            Label {
                id: dtflux
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
                }

                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeExtraLarge
                color: Theme.secondaryHighlightColor
            }
        }
    }
}


