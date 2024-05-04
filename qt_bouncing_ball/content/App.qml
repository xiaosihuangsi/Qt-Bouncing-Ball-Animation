
import QtQuick 6.5
import QtQuick.Controls 2.15

ApplicationWindow {
    width: 400
    height: 300
    visible: true
    title: "Bouncing ball"

    Canvas {
        id: drawingCanvas
        anchors.fill: parent

        // Ball properties
        property real ballX: 200
        property real ballY: 150
        property real dx: 2  // Horizontal velocity
        property real dy: 2  // Vertical velocity
        property real ballRadius: 25

        // Rectangle properties
        property real rectX: 30
        property real rectY: 30

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            // Draw gradient background
            var gradient = ctx.createLinearGradient(0, 0, width, 0)
            gradient.addColorStop(0, "lightpink")
            gradient.addColorStop(1, "darkgreen")
            ctx.fillStyle = gradient
            ctx.fillRect(0, 0, width, height)

            // Draw the ball
            ctx.beginPath()
            ctx.arc(ballX, ballY, ballRadius, 0, 2 * Math.PI, false)
            ctx.fillStyle = 'red'
            ctx.fill()

            // Draw the rectangle
            ctx.fillStyle = "green"
            ctx.fillRect(rectX, rectY, 50, 50)
        }
    }

    Timer {
        id: animationTimer
        interval: 20  // 50 fps
        repeat: true
        running: false
        onTriggered: {
            // Update ball position
            drawingCanvas.ballX += drawingCanvas.dx
            drawingCanvas.ballY += drawingCanvas.dy

            // Boundary collision detection and bounce
            if (drawingCanvas.ballX > drawingCanvas.width - drawingCanvas.ballRadius || drawingCanvas.ballX < drawingCanvas.ballRadius) {
                drawingCanvas.dx = -drawingCanvas.dx  // Reverse horizontal direction
            }
            if (drawingCanvas.ballY > drawingCanvas.height - drawingCanvas.ballRadius || drawingCanvas.ballY < drawingCanvas.ballRadius) {
                drawingCanvas.dy = -drawingCanvas.dy  // Reverse vertical direction
            }

            drawingCanvas.requestPaint()  // Request canvas redraw
        }
    }

    Button {
        id: startTimer
        anchors.bottom: parent.bottom
        text: "Start / Stop"
        onClicked: {
            animationTimer.running = !animationTimer.running  // Toggle animation timer
        }
    }
}









/*

import QtQuick 6.5
import QtQuick.Controls 2.15

ApplicationWindow {
    width: 400
    height: 300
    visible: true
    title: "Week5_example"

    ListModel {
        id: nameModel
        ListElement { name: "Alice" }
        ListElement { name: "Bob" }
        ListElement { name: "Jane" }
    }

    Component {
        id: nameDelegate
        Text {
            text: name
            font.pixelSize: 30
        }
    }

    ListView {
        anchors.fill: parent
        anchors.bottomMargin: 40  // Leave space for TextField and Button
        model: nameModel
        delegate: nameDelegate
        clip: true
    }

    TextField {
        id: addName
        width: parent.width - 100  // Leave space for the Button
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        placeholderText: "Type a new name here..."
    }

    Button {
        text: "Add Name"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        onClicked: {
            if (addName.text.trim() !== "") {  // Check if the TextField is not empty or just whitespace
                nameModel.append({"name": addName.text});  // Append the new item
                addName.text = "";  // Clear the TextField
            }
        }
    }
}

*/

