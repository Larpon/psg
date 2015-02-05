import QtQuick 2.4
import QtQuick.Particles 2.0

Item {
    anchors.fill: parent

    Timer {
        interval: 2500
        //triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            shockWave.burst(500);

            //fire.burst(500);
        }
    }

    Timer {
        interval: 2500
        //triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            //core.enabled = !core.enabled
            core.burst(10);
        }
    }

    Timer {
        interval: 2500
        //triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            //core.enabled = !core.enabled
            core2.burst(5);
        }
    }


    ParticleSystem {
        id: particles
        anchors.fill: parent

        ImageParticle {
            id: smoke

            anchors.fill: parent
            groups: ["A", "B"]
            source: "images/glowdot.png"
            colorVariation: 0
            color: "#00111111"
        }

        ImageParticle {
            id: flame
            anchors.fill: parent
            system: particles
            groups: ["C", "D"]
            source: "images/glowdot.png"
            colorVariation: 0.1
            color: "#22ff400f"
        }

        ImageParticle {
            id: molten
            anchors.fill: parent
            system: particles
            groups: ["E"]
            //source: "images/explosion_texture.png"
            source: "images/glowdot.png"
            colorVariation: 0.1
            color: "#11db3c0b"
        }

        ImageParticle {
            id: moltenY
            anchors.fill: parent
            system: particles
            groups: ["F"]
            source: "images/glowdot.png"
            colorVariation: 0.1
            color: "#aadb3c0b"
        }



        Emitter {
            id: shockWave

            anchors.centerIn: parent

            group: "A"

            emitRate: 1000
            lifeSpan: 500
            enabled: false
            velocity: AngleDirection { magnitude: 264; angleVariation: 360 }
            size: 14
            sizeVariation: 8

        }

        Emitter {
            id: core
            anchors.centerIn: parent
            enabled: false
            group: "core"

            emitRate: 1000
            lifeSpan: 500

            velocity: AngleDirection { magnitude: 64; angleVariation: 360 }
            acceleration: PointDirection { yVariation: 6*6; xVariation: 6*6 }

            size: 8
            sizeVariation: 4

            endSize: 8
        }

        TrailEmitter {
            id: coreYellow

            system: particles
            group: "D"
            follow: "core"

            emitRatePerParticle: 120
            lifeSpan: 480

            velocity: AngleDirection { magnitude: 64; angleVariation: 360 }
            acceleration: PointDirection { yVariation: 6*6; xVariation: 6*6 }

            /*
            emitWidth: TrailEmitter.ParticleSize
            emitHeight: TrailEmitter.ParticleSize
            emitShape: EllipseShape{}
*/
            size: 16
            sizeVariation: 4
            endSize: 16
        }

        TrailEmitter {
            id: coreRed
            anchors.fill: parent

            group: "E"
            follow: "core"

            emitRatePerParticle: 120
            lifeSpan: 180
            emitWidth: TrailEmitter.ParticleSize
            emitHeight: TrailEmitter.ParticleSize
            emitShape: EllipseShape{}

            emitRate: 300

            velocity: AngleDirection { magnitude: 44; angleVariation: 360 }
            acceleration: PointDirection { yVariation: 6*6; xVariation: 6*6}


            size: 40
            sizeVariation: 2
            endSize: 10
        }


        Emitter {
            id: core2
            anchors.centerIn: parent
            enabled: false
            group: "core2"

            emitRate: 1000
            lifeSpan: 500

            velocity: AngleDirection { magnitude: 64; angleVariation: 360 }
            acceleration: PointDirection { yVariation: 6*6; xVariation: 6*6 }

            size: 8
            sizeVariation: 4

            endSize: 8
        }

        TrailEmitter {
            id: core2Red
            anchors.fill: parent

            group: "F"
            follow: "core2"

            emitRatePerParticle: 120
            lifeSpan: 180
            emitWidth: TrailEmitter.ParticleSize
            emitHeight: TrailEmitter.ParticleSize
            emitShape: EllipseShape{}

            emitRate: 300

            velocity: AngleDirection { magnitude: 44; angleVariation: 360 }
            acceleration: PointDirection { yVariation: 6*6; xVariation: 6*6}


            size: 40
            sizeVariation: 2
            endSize: 10
        }


        /*
        Emitter {
            id: fire
            system: particles
            group: "C"

            anchors.centerIn: parent
            width: 40

            emitRate: 350
            lifeSpan: 500

            velocity: AngleDirection { magnitude: 34; angleVariation: 360 }
            size: 44
            sizeVariation: 130

            //endSize: 4
        }
*/
        /*
        Emitter {
            id: pulseEmitter
            x: parent.width/2
            y: 2*parent.height/3
            emitRate: 1000
            lifeSpan: 2000
            enabled: false
            velocity: AngleDirection{magnitude: 64; angleVariation: 360}
            size: 24
            sizeVariation: 8
            Text {
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 18
                text: "Pulse"
            }
        }
        */
    }
}
