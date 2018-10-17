import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    id: root

    ParticleSystem {
        id: particles
        anchors.centerIn: parent
        //anchors.fill: parent

        Timer {
            interval: 4000
            triggeredOnStart: true
            running: true
            repeat: true
            onTriggered: {
                burstEmitter.burst(40);
            }
        }

        Emitter {
            id: burstEmitter

            system: particles
            group: "E"

            //anchors.centerIn: parent

            emitRate: 1
            lifeSpan: 3500
            enabled: false
            velocity: AngleDirection { magnitude: 264; angle: -90; angleVariation: 90 }//AngleDirection { magnitude: 264; angleVariation: 360 }
            acceleration: PointDirection { y: -17; xVariation: 6*6; yVariation: 6*6 }
            size: 10
            sizeVariation: 4
        }

        ImageParticle {
            id: smoke
            system: particles
            anchors.fill: parent
            groups: ["A", "B"]
            source: 'images/glowdot.png'
            colorVariation: 0
            color: "#00111111"
        }

        ImageParticle {
            id: flame
            anchors.fill: parent
            system: particles
            groups: ["C", "D"]
            source: 'images/glowdot.png'
            colorVariation: 0.1
            color: "#00ff400f"
        }

        TrailEmitter {
            id: fireSmoke
            group: "B"
            system: particles
            follow: "C"
            width: root.width
            height: root.height - 68

            emitRatePerParticle: 1
            lifeSpan: 2000

            velocity: PointDirection { y:-17*6; yVariation: -17; xVariation: 3 }
            acceleration: PointDirection { xVariation: 3 }

            size: 36
            sizeVariation: 8
            endSize: 16
        }

        TrailEmitter {
            id: fireballFlame
            anchors.fill: parent
            system: particles
            group: "D"
            follow: "E"

            emitRatePerParticle: 120
            lifeSpan: 180
            emitWidth: TrailEmitter.ParticleSize
            emitHeight: TrailEmitter.ParticleSize
            emitShape: EllipseShape{}

            size: 16
            sizeVariation: 4
            endSize: 4
        }

        TrailEmitter {
            id: fireballSmoke
            anchors.fill: parent
            system: particles
            group: "A"
            follow: "E"

            emitRatePerParticle: 128
            lifeSpan: 2400
            emitWidth: TrailEmitter.ParticleSize
            emitHeight: TrailEmitter.ParticleSize
            emitShape: EllipseShape{}

            velocity: PointDirection { yVariation: 16; xVariation: 16 }
            acceleration: PointDirection { y: -16 }

            size: 24
            sizeVariation: 8
            endSize: 8
        }

        Turbulence { //A bit of turbulence makes the smoke look better
            anchors.fill: parent
            groups: ["A","B"]
            strength: 62
            system: particles
        }
    }
}


