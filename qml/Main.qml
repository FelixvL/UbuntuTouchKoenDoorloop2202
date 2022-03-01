/*
 * Copyright (C) 2022  felix
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * trainingmetkoen is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'trainingmetkoen.felix'
    automaticOrientation: true

   property string abc: 'go'


    width: units.gu(45)
    height: units.gu(75)

    Page {
        id: paginaDE
        anchors.fill: parent

         
        MouseArea{
            anchors.fill:parent
            onClicked:console.log("op de pagina")

        }

        header: PageHeader {
            id: header
            title: i18n.tr('Dit is de titel')
            
           
            Button{
                id: button
                text:"AddItem"
                color:"red"

                onClicked: {
                    var a = 23;
                    a++;
                    a = a +35;
                    console.log("hoi"+a);
                    console.log("Doei");
                    color = 'blue';
                    text = abc;
                    text = mijnInvoer.text;
                    ikgaietsdoen(55);
                    voegietstoe();
                }

                anchors {
                    top: header.bottom
                    right: parent.right
                }
                anchors.rightMargin: units.gu(2)

            }
            StyleHints{
                backgroundColor: UbuntuColors.orange

            }
            
        }

        Label {
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            text: i18n.tr('Bouw je boodschappenlijstje')

            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter

            TextField{
                id: mijnInvoer
                anchors.left: parent.left
                
            }
            
        }
        
        ListModel{
            id: mylist

            function addItem(){
                var item = {
                    "name":"iets",
                    "prijs":200
                }
                console.log("kom je daar?");
                mylist.append(item);
                listView.refresh();
            }
        }

        ListView{
            id: listView
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: paginaDE.bottom
            anchors.top:header.bottom
            anchors.topMargin: units.gu(5)

            model: mylist

            function refresh(){
                var tmp = model;
                model = null;
                model = tmp;
            }

            delegate: ListItem{
                width: parent.width
                height:units.gu(5)

                Text{
                    text: 'in item'
                }
                Text{
                    id: itemnaam
                    text:prijs
                }
            }
        }
    }

    function ikgaietsdoen(getal){
        console.log("het doet het"+getal);
    }

    function voegietstoe(){
        mylist.addItem();
        console.log("kom je hier?");
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));

            importModule('example', function() {
                console.log('module imported');
                python.call('example.speak', ['Hello World!'], function(returnValue) {
                    console.log('dit komt van python tijdens het opstarten ' + returnValue);
                })
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
