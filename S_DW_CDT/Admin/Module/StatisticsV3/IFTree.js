	activeObj = "";
		function mo(obj){
			if(activeObj != obj){
				obj.className = "RMO";
			}
		}

		function no(obj){
			if(activeObj != obj){
				obj.className = "RNO";
			}
		}

		function ac(obj, reportScript){
			activeObj.className = "RNO";
			obj.className = "RAC";
			activeObj = obj;
			window.parent._reportScript = reportScript;
			window.parent.changeFilter();
			window.parent.changeReportSrc();
		}

		function res(){
			activeObj.className = "RNO";
			activeObj = "";
		}
		
		function toggle(obj){
		if(document.getElementById(obj.id + 'r').style.display == ""){
			document.getElementById(obj.id + 'i').src = "/Admin/Images/Expand2.gif"
			document.getElementById(obj.id + 'r').style.display = "none";
		}
		else{
			document.getElementById(obj.id + 'i').src = "/Admin/Images/Expand_off2.gif"
			document.getElementById(obj.id + 'r').style.display = "";
		}
		}