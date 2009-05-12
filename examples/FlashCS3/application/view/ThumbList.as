﻿/**
 * 小图集合面板
 * ibio-develop
 * 2009-5-12 11:42
 */
package application.view {
	import org.weemvc.as3.view.View;
	import application.model.vo.ImageVO;
	import application.actions.ShowImageCommand;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ThumbList extends View {
		protected var m_panel:MovieClip;
		protected var m_playList:Array;
		protected var m_arrowYList:Array = [0, 62.5, 125.0, 187.5];
		protected var m_tweenY:Tween;
		
		public function ThumbList(target:MovieClip) {
			m_panel = target;
			notifications = [Main.PLAY_LIST_LOADED];
		}
		
		override public function onDataChanged(notification:String, data:Object = null):void {
			if (notification == Main.PLAY_LIST_LOADED) {
				init(data as Array);
			}
		}
		
		public function init(playList:Array):void {
			m_playList = playList;
			buildThumbs();
			//默认是选中第1张
			m_panel["mc_thumb" + 0].selected = true;
			sendNotification(ShowImageCommand, 0);
		}
		
		protected function buildThumbs():void {
			for (var i = 0; i < m_playList.length; i++) {
				var imageData:ImageVO = m_playList[i] as ImageVO;
				m_panel["mc_thumb" + i].index = i;
				m_panel["mc_thumb" + i].setData(imageData.title, imageData.subtitle);
				m_panel["mc_thumb" + i].addEventListener(MouseEvent.CLICK, onThumbClick_handler);
			}
		}
		
		protected function onThumbClick_handler(e:MouseEvent):void {
			//清除之前的
			for (var i = 0; i < m_playList.length; i++) {
				m_panel["mc_thumb" + i].selected = false;
			}
			m_panel["mc_thumb" + e.currentTarget.index].selected = true;
			//
			var newY:uint = m_arrowYList[e.currentTarget.index];
			try {
				m_tweenY.stop();
			}catch (e:Error) {
				trace("ThumbList::onThumbClick_handler:", e.message);
			}
			m_tweenY = new Tween(m_panel.mc_arrow, "y", Strong.easeOut, m_panel.mc_arrow.y, newY, 1.5, true);
			//trace("当前点击：", e.currentTarget.index);
			sendNotification(ShowImageCommand, e.currentTarget.index);
		}
	}
}