// JScript File


        function tab_activate(strValue)
        { 
        //alert("hi");
//        alert(strValue);	
//        $(activetab).className = 'tabs';
//        $tab).className = 'tabactive';
//        activetab = "tab2";
//        return true;
       }

function checkEvent(tmpObj)
  {	
        
        //alert("tmpObj : " + tmpObj);
        if (window.event.keyCode==13)
        {
             eval("document.getElementById('" + tmpObj + "')").focus();
          
        }
   }
