﻿/**
 * 程序初始化命令
 * 注册所有的命令
 * ibio-develop
 * 2009-1-5 14:07
 */
import org.weemvc.as2.control.ICommand;
import org.weemvc.as2.control.SimpleCommand;
import application.actions.LoadDataCommand;
import application.actions.ShowImageCommand;
import application.model.DataProxy;
import application.view.*;
	
class application.actions.StartupCommand extends SimpleCommand implements ICommand {
	public static var NAME:String = "startup";
		
	public function execute(data:Object, viewName:Object):Void {
		addViews();
		addModels();
		addCommands();
		//初始化view
		viewLocator.initialize(MovieClip(data));
	}
	
	private function addViews():Void {
		viewLocator.addView(StageInitialize.NAME, StageInitialize);
		viewLocator.addView(BigImagePlayer.NAME, BigImagePlayer, "mc_bigImagePlayer");
		viewLocator.addView(ThumbList.NAME, ThumbList, "mc_thumbList");
	}
	
	private function addModels():Void {
		modelLocator.addModel(DataProxy.NAME, DataProxy);
	}
	
	private function addCommands():Void {
		controller.addCommand(LoadDataCommand.NAME, LoadDataCommand);
		controller.addCommand(ShowImageCommand.NAME, ShowImageCommand);
	}
}