import QtQuick 2.4
import QtQuick.Particles 2.0

Item {
    anchors.fill: parent

    ParticleSystem {
        id: particles
        anchors.fill: parent

    }

    Timer {
        interval: 800
        //triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            //boofEmitter.burst(5);
            boofEmitter.enabled = !boofEmitter.enabled
            //boofEmitter.burst(5);
        }
    }

    ImageParticle {
        objectName: "boof"
        groups: [""]
        source: "images/glowdot.png"
        color: "#5a5a5a"
        colorVariation: 0
        alpha: 0.5
        alphaVariation: 0.2
        redVariation: 0
        greenVariation: 0
        blueVariation: 0
        rotation: 0
        rotationVariation: 0
        autoRotation: false
        rotationVelocity: 0
        rotationVelocityVariation: 0
        entryEffect: ImageParticle.Scale
        system: particles
    }

    Emitter {
		id: boofEmitter
        objectName: "boofEmitter"

        /*
        x: 195
        y: 197
        width: 100
        height: 100
        */

        anchors { fill: parent }

        enabled: false
        group: ""
        emitRate: 750
        maximumEmitted: -1
        startTime: 600
        lifeSpan: 800
        lifeSpanVariation: 0
        size: 60
        sizeVariation: 3
        endSize: 10
        velocityFromMovement: 0
        system: particles
        velocity:
            PointDirection {
                x: 0
                xVariation: 0
                y: 0
                yVariation: 0
            }
        acceleration:
            PointDirection {
                x: 0
                xVariation: -1
                y: 0
                yVariation: -1
            }
        shape:
            EllipseShape {
                fill: true
            }
    }

}


