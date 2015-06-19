package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	public class Test843 extends Sprite
	{
		private var socket:Socket;
		public function Test843()
		{
			Security.loadPolicyFile("xmlsocket://127.0.0.1:4000");
			go();
		}
		public function go():void 
		{
			socket = new Socket();
			Security.allowDomain("*");
			
			this.socket.addEventListener(Event.CONNECT, function(e:Event):void {
				SendChat("socket data");
			});
			this.socket.addEventListener(ProgressEvent.SOCKET_DATA, function(e:ProgressEvent):void {
				trace("接收到服务端的数据:"+socket.readUTFBytes(socket.bytesAvailable));
			});
			this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:SecurityErrorEvent):void {
				trace(e.text);
			});
			this.socket.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void{
				trace(e.text);
			});
			this.socket.connect("127.0.0.1",843);
		}
		
		private function SendChat(s:String):void
		{
			if (s.length == 0) {
				return;
			}
			var buffer:ByteArray = new ByteArray();
			buffer.writeMultiByte(s+"\n","utf8");
			trace("发送了"+buffer.length+"字节");
			this.socket.writeBytes(buffer, 0, buffer.length);
			this.socket.flush();
			
		}
	}
}