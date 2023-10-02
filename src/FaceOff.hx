package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;
import flixel.util.FlxSave;
import flixel.math.FlxRandom;


#if desktop
import Discord.DiscordClient;
#end

//crash handler stuff
#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end
import caching.*;

using StringTools;

class FaceOff
{
    //To use Run init() and then faceOff(number) whenever
    public static var cams:Array<FlxCamera> = [];

    public static function faceOff(phase:Int) { // EXAMPLE
        switch(PlayState.phase){
            case 1:
                FlxTween.tween(cams[0],{y:0},0.2,{ease:FlxEase.expoOut});
            case 6:
                FlxTween.tween(cams[1],{y:0},0.2,{ease:FlxEase.expoOut});
            case 12:
                FlxTween.tween(cams[0],{zoom:0.6},3,{ease:FlxEase.sineOut});
                FlxTween.tween(cams[1],{zoom:0.6},3,{ease:FlxEase.sineOut});
            case 16:
                FlxTween.tween(cams[1],{y:-720},0.4,{ease:FlxEase.expoIn});
                FlxTween.tween(cams[0],{y:720},0.4,{ease:FlxEase.expoIn});
        }
    }
    public static function init() {
        cams[0] = new FlxCamera();
        cams[0].copyFrom(PlayState.camGame);
        cams[0].x = 0;
        cams[0].y = 0;
        cams[0].width = 1280/2;
        cams[0].height = 720;
        cams[0].zoom = 1.6;
    
        cams[0].scroll.x = PlayState.dad.getMidpoint().x - 150;
        cams[0].scroll.x = cams[0].scroll.x - (PlayState.dad.cameraPosition[0] - PlayState.opponentCameraOffset[0]);
        cams[0].scroll.y = PlayState.dad.getMidpoint().y - 175;
        cams[0].scroll.y = cams[0].scroll.y + (PlayState.dad.cameraPosition[1] - PlayState.opponentCameraOffset[1]);
        cams[0].scroll.x -= 200;
        cams[0].scroll.y-= 330;
        
        cams[0].target = null;
        FlxG.cameras.add(cams[0]);
        cams[0].y-=720;
        cams[0].setFilters([new ShaderFilter(PlayState.bloom)]);
    
    
        cams[1]= new FlxCamera();
        cams[1].copyFrom(PlayState.camGame);
        cams[1].x = 1280/2;
        cams[1].y = 0;
        cams[1].width = 1280/2;
        cams[1].height = 720;
        cams[1].zoom = 2;
    
        cams[1].scroll.x = PlayState.boyfriend.getMidpoint().x - 150;
        cams[1].scroll.x = cams[1].scroll.x - (PlayState.boyfriend.cameraPosition[0] - PlayState.boyfriendCameraOffset[0]);
        cams[1].scroll.y = PlayState.boyfriend.getMidpoint().y - 175;
        cams[1].scroll.y = cams[1].scroll.y + (PlayState.boyfriend.cameraPosition[1] - PlayState.boyfriendCameraOffset[1]);
        cams[1].scroll.x -= 200;
        cams[1].scroll.y-= 200;
        cams[1].scroll.y-=150;
        cams[1].target = null;
        FlxG.cameras.add(cams[1]);
        FlxG.cameras.add(camHUD);
        cams[1].setFilters([new ShaderFilter(PlayState.bloom)]);
    
        FlxCamera.defaultCameras = [cams[0], cams[1], PlayState.camGame];
        cams[0].zoom = 1;
        cams[1].y+= 720;
        cams[0].zoom = 1;
        cams[1].zoom = 1;
        
    }
}