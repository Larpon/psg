import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    id: root

    ParticleSystem {
        id: particles
        anchors.fill: parent

        ImageParticle {
            groups: ["center","edge"]
            anchors.fill: parent
            source: 'images/glowdot.png'
            colorVariation: 0.1
            color: "#009999FF"
        }

        Emitter {
            anchors.fill: parent
            group: "center"
            emitRate: 400
            lifeSpan: 2000
            size: 20
            sizeVariation: 2
            endSize: 0
            //! [0]
            shape: EllipseShape {fill: false}
            velocity: TargetDirection {
                targetX: root.width/2
                targetY: root.height/2
                proportionalMagnitude: true
                magnitude: 0.5
            }
            //! [0]
        }

        Emitter {
            anchors.fill: parent
            group: "edge"
            startTime: 2000
            emitRate: 2000
            lifeSpan: 2000
            size: 28
            sizeVariation: 2
            endSize: 16
            shape: EllipseShape {fill: false}
            velocity: TargetDirection {
                targetX: root.width/2
                targetY: root.height/2
                proportionalMagnitude: true
                magnitude: 0.1
                magnitudeVariation: 0.1
            }
            acceleration: TargetDirection {
                targetX: root.width/2
                targetY: root.height/2
                targetVariation: 200
                proportionalMagnitude: true
                magnitude: 0.1
                magnitudeVariation: 0.1
            }
        }
    }
}
