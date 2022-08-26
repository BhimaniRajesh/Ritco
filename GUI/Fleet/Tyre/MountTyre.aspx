<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="MountTyre.aspx.cs" Inherits="TYRE1_MountTyre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

<script language="javascript">
function validFloat(event,txtid)
{
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
    return true;

    if(event.keyCode==46)
    if(txt.indexOf('.')!=-1)
    event.keyCode=0;
    
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
    {event.keyCode=0;return false;}
} 

    function func(pnlDismountTyre,pnlMountTyre)
    {
//        pnlDismountTyre.disabled=true
//        pnlMountTyre.disabled=true;
        pnlMountTyre.style.visibility="hidden";
        pnlDismountTyre.style.visibility="hidden";
        
    }
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function ValidateTyreNo()
    {
        //CHECK TYRE NUMBER
        var no = document.getElementById("ctl00$MyCPH1$txtTyreNo").value;
        if(no=="")
        {
            alert("Please Enter Tyre No!!!")
            document.getElementById("ctl00$MyCPH1$txtTyreNo").focus()
            return false;
        }
    }
    function ValidateDismountTyre()
    {
        //CHECK VALIDATION FOR DISMOUNT TYRE
        var tdate = document.getElementById("ctl00$MyCPH1$tb_Date").value;
        if(tdate=="")
        {
            alert("Please Enter Date!!!")
            document.getElementById("ctl00$MyCPH1$tb_Date").focus()
            return false;
        }
        
        var tLabourHours= document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").value;
        if(tLabourHours=="")
        {
            alert("Please Enter Total Labour Hours!!!")
            document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").focus()
            return false;
        }
        if(isNaN(tLabourHours))
        {
            alert("Please Enter Total Labour Hours in Numeric!!!");
            document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").value="";
            document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").focus();
            return false;
        }
        var tLabourCost= document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").value; 
        if(tLabourCost=="")
        {
            alert("Please Enter Total Labour Cost!!!")
            document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").focus()
            return false;
        }
        if(isNaN(tLabourCost))
        {
            alert("Please Enter Total Labour Cost in Numeric!!!");
            document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").value="";
            document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").focus();
            return false;
        }
        
        var drea = document.getElementById("ctl00$MyCPH1$ddlTyreDismountReason").value;
        if(drea=="0")
        {
            alert("Please Select Reason for Dismount Tyre!!!")
            document.getElementById("ctl00$MyCPH1$ddlTyreDismountReason").focus()
            return false;
        }
        
        var trem = document.getElementById("ctl00$MyCPH1$txtRemark").value;
        if(trem=="")
        {
            alert("Please Enter Remarks!!!")
            document.getElementById("ctl00$MyCPH1$txtRemark").focus()
            return false;
        }
        
        var dloc = document.getElementById("ctl00$MyCPH1$ddlLocation").value; 
        if(dloc=="0")
        {
            alert("Please Select Location!!!")
            document.getElementById("ctl00$MyCPH1$ddlLocation").focus()
            return false;
        }
    }
    function ValidateMountTyre()
    {
        //CHECK VALIDATION FOR MOUNT TYRE
        var tdate = document.getElementById("ctl00$MyCPH1$tb_Date").value;
        if(tdate=="")
        {
            alert("Please Enter Date!!!")
            document.getElementById("ctl00$MyCPH1$tb_Date").focus()
            return false;
        }
        
        var tLabourHours= document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").value;
        if(tLabourHours=="")
        {
            alert("Please Enter Total Labour Hours!!!")
            document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").focus()
            return false;
        }
        if(isNaN(tLabourHours))
        {
            alert("Please Enter Total Labour Hours in Numeric!!!");
            document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").value="";
            document.getElementById("ctl00$MyCPH1$txtTotalLabourHours").focus();
            return false;
        }
        
        var tLabourCost= document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").value; 
        if(tLabourCost=="")
        {
            alert("Please Enter Total Labour Cost!!!")
            document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").focus()
            return false;
        }
        if(isNaN(tLabourCost))
        {
            alert("Please Enter Total Labour Cost in Numeric!!!");
            document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").value="";
            document.getElementById("ctl00$MyCPH1$txtTotalLabourCost").focus();
            return false;
        }
        
        var tvehno = document.getElementById("ctl00$MyCPH1$txtVehNo").value; 
        if(tvehno=="")
        {
            alert("Please Enter Vehicle Number!!!")
            document.getElementById("ctl00$MyCPH1$txtVehNo").focus()
            return false;
        }
        var dpos = document.getElementById("ctl00$MyCPH1$ddlTyrePosition").value;  
        if(dpos=="0")
        {
            alert("Please Select New Position of Tyre!!!")
            document.getElementById("ctl00$MyCPH1$ddlTyrePosition").focus()
            return false;
        }
    }
    function checkVehNo()
    {
        var currentTime = new Date()
        var str_Index = "";
        if (document.getElementById("ctl00_MyCPH1_txtVehNo").value == "")
        {
            document.getElementById("ctl00_MyCPH1_txtVehNo").value="";
            document.getElementById("ctl00_MyCPH1_hfVehIntId").value="";
            document.getElementById("<%=hfPosCategory.ClientID %>").value=""; 
            document.getElementById("<%=hfTruckTrailer.ClientID %>").value=""; 
            return;
        }

        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                        alert("Invalid Vehicle Number");
                        document.getElementById("ctl00_MyCPH1_txtVehNo").value="";
                        document.getElementById("ctl00_MyCPH1_hfVehIntId").value="";
                        document.getElementById("<%=hfPosCategory.ClientID %>").value=""; 
                        document.getElementById("<%=hfTruckTrailer.ClientID %>").value=""; 
                        document.getElementById("<%=txtKM.ClientID %>").value=""; 
                        document.getElementById("ctl00_MyCPH1_txtVehNo").focus();
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_txtVehNo").value=returnValue[1];
                        document.getElementById("ctl00_MyCPH1_hfVehIntId").value=returnValue[2];
                        document.getElementById("<%=hfPosCategory.ClientID %>").value=returnValue[4];
                        document.getElementById("<%=hfTruckTrailer.ClientID %>").value=returnValue[5];
                        document.getElementById("<%=txtKM.ClientID %>").value=returnValue[6];
                        ConSP();
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidVehNoTyreMount&datetime="+currentTime+"&km="+ document.getElementById("<%=txtKM.ClientID %>").value+"&VehNo=" + document.getElementById("ctl00_MyCPH1_txtVehNo").value, false);
            xmlHttpRequest.send(null);
        }
    }
 
    function checkManualVehicleOdometerReading(txtManualKMRead)
    {
        var currentTime = new Date()
        var str_Index = "";
        
        var hfTyreId = document.getElementById("ctl00_MyCPH1_hfTyreId");
        var pnlMountTyre = document.getElementById("ctl00_MyCPH1_pnlMountTyre");
        var pnlDismountTyre = document.getElementById("ctl00_MyCPH1_pnlDismountTyre");
        
        if (txtManualKMRead.value == "")
        {
            return true;
        }
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "Y") 
                    {
                        if(pnlMountTyre.style.visibility=="visible")
                        {
                            if(parseFloat(txtManualKMRead.value) < parseFloat(returnValue[2]))
                            {
                                alert("Manual vehicle odometer reading is must be greatae than last dismounted amount.\nLast Dismount Amount is " + returnValue[2]);
                                txtManualKMRead.focus();
                                return false;
                            }
                        }
                        if(pnlDismountTyre.style.visibility=="visible")
                        {
                            if(parseFloat(txtManualKMRead.value) < parseFloat(returnValue[1]))
                            {
                                alert("Manual vehicle odometer reading is must be greatae than last mounted amount.\nLast Mount Amount is " + returnValue[1]);
                                txtManualKMRead.focus();
                                return false;
                            }
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckManualVehicleOdometerReading&datetime="+currentTime+"&TyreId="+ hfTyreId.value, false);
            xmlHttpRequest.send(null);
        }
    }
    
    function GetTyreDetails(txtTyreNo,txtTyreSize,txtTyrePattern,txtTyrePosition,txtManufacturer,hfVehIntId,txtVehNumber,pnlMountTyre,pnlDismountTyre,Label7,hfTyreId,hfPosCategory,hfTruckTrailer,txtCurrentKMRead)
    {
        var lDate = document.getElementById("<%=Label12.ClientID %>");
        
        if(txtTyreNo.value=="")
        {
            txtTyreSize.value="";
            txtTyrePattern.value="";
            txtTyrePosition.value="";
            txtManufacturer.value="";
            txtVehNumber.value="";
            hfVehIntId.value="";
            hfTyreId.value="";
            hfPosCategory.value="";
            hfTruckTrailer.value="";
            pnlDismountTyre.style.visibility="hidden";
            pnlMountTyre.style.visibility="hidden";
            lDate.innerText="Date :";
            txtCurrentKMRead.value="";
            return true;
        }
        var currentTime = new Date()
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N")
                    {
                        txtTyreSize.value="";
                        txtTyrePattern.value="";
                        txtTyrePosition.value="";
                        txtManufacturer.value="";
                        txtVehNumber.value="";
                        hfVehIntId.value="";
                        hfTyreId.value="";
                        hfPosCategory.value="";
                        hfTruckTrailer.value="";
                        lDate.innerText="Date :";
                        pnlDismountTyre.style.visibility="hidden";
                        pnlMountTyre.style.visibility="hidden";
                        alert("Invalid Tyre Number!!!");
                        txtTyreNo.focus();
                        return false;
                        
                    }
                    else
                    {
                        if(returnValue[12]=="Scrapped")
                        {
                            txtTyreSize.value="";
                            txtTyrePattern.value="";
                            txtTyrePosition.value="";
                            txtManufacturer.value="";
                            txtVehNumber.value="";
                            hfVehIntId.value="";
                            hfTyreId.value="";
                            hfPosCategory.value="";
                            hfTruckTrailer.value="";
                            lDate.innerText="Date :";
                            pnlDismountTyre.style.visibility="hidden";
                            pnlMountTyre.style.visibility="hidden";
                            alert("Tyre was scrapped !!!");
                            txtTyreNo.focus();
                            return false;
                        }
                        else
                        {
                            txtTyreSize.value=returnValue[1];
                            txtTyrePattern.value=returnValue[2];
                            txtTyrePosition.value=returnValue[3];
                            txtManufacturer.value=returnValue[4];
                            hfVehIntId.value=returnValue[6];
                            if(hfVehIntId.value == "")
                            {
                                lDate.innerText="Mount Date :";
                                pnlMountTyre.style.visibility="visible";
                                pnlDismountTyre.style.visibility="hidden";
                                Label7.innerText="Location:";
                                txtVehNumber.value=returnValue[7];
                                
                            }
                            else
                            {
                                lDate.innerText="Dismount Date :";
                                Label7.innerText="Vehicle Number :";
                                txtVehNumber.value=returnValue[5];
                                pnlMountTyre.style.visibility="hidden";
                                pnlDismountTyre.style.visibility="visible";
                            }
                            hfTyreId.value=returnValue[8];
                            hfPosCategory.value=returnValue[9];
                            hfTruckTrailer.value=returnValue[10];
                            txtCurrentKMRead.value=returnValue[11];
                        }
                        //ConSP();
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetTyreDetails&datetime="+currentTime+"&TyreNo=" + txtTyreNo.value, false);
            xmlHttpRequest.send(null);
        }	
    }
  
    function ConSP()
    {
        var currentTime = new Date()
        var hfPosCategory=document.getElementById("<%=hfPosCategory.ClientID %>"); 
        var hfTruckTrailer=document.getElementById("<%=hfTruckTrailer.ClientID %>"); 
        var ddlTyrePosition=document.getElementById("<%=ddlTyrePosition.ClientID %>"); 
        var hfVehIntId=document.getElementById("<%=hfVehIntId.ClientID %>"); 
        
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                    }
                    else
                    {
                        removeAllOptions(ddlTyrePosition);
                        var PC= "";
                        var PI="";
                        if(returnValue[1] == "")
                        {
                            PC= "Select";
                            PI="0";
                        }
                        else
                        {
                            PC= "Select," + returnValue[1];
                            PI= "0," + returnValue[2];
                        }
                        var PosCode=PC.split(",");
                        var PosId=PI.split(",");
                        var part_num=0;
                        
                        while (part_num < PosCode.length)
                        {
                            addOption(ddlTyrePosition, PosCode[part_num], PosId[part_num]);
                            part_num+=1;
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetTyrePosition&datetime="+currentTime+"&PosAllow=" + hfPosCategory.value+"&TT="+hfTruckTrailer.value+"&VehNo="+hfVehIntId.value, false);
            xmlHttpRequest.send(null);
        }
    }
    function removeAllOptions(selectbox)
    {
        var i;
        for(i=selectbox.options.length-1;i>=0;i--)
        {
            selectbox.remove(i);
        }
    }
    function addOption(selectbox,text,value )
    {
        var optn = document.createElement("OPTION");
        optn.text = text;
        optn.value = value;
        selectbox.options.add(optn);
    }
    
    function ValidateDate(obj) 
    {
        if (obj.value != "") 
        {
            if (isDate(obj.value) == false) 
            {
                obj.focus();
                return false;
            }
            return true;
        }
    }
    var dtCh = "/";
    var minYear = "1900";
    var maxYear = "2100";
    function DaysArray(n)
    {
        for (var i = 1; i <= n; i++) 
        {
            this[i] = 31
            if (i == 4 || i == 6 || i == 9 || i == "11") { this[i] = 30 }
            if (i == 2) { this[i] = 29 }
        }
        return this;
    }
    function isDate(dtStr) 
    {
        var daysInMonth = DaysArray(12)
        var pos1 = dtStr.indexOf(dtCh)
        var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
        var strDay = dtStr.substring(0, pos1)
        var strMonth = dtStr.substring(pos1 + 1, pos2)
        var strYear = dtStr.substring(pos2 + 1)
        strYr = strYear
        if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
        if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
        for (var i = 1; i <= 3; i++) {
            if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
        }

        month = parseInt(strMonth)
        day = parseInt(strDay)
        year = parseInt(strYr)
        if (pos1 == -1 || pos2 == -1) {
            alert("The date format should be : dd/mm/yyyy");
            return false;
        }
        if (strMonth.length < 1 || month < 1 || month > 12) {
            alert("Please enter a valid month");
            return false;
        }
        if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
            alert("Please enter a valid day");
            return false;
        }
        if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
            alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear);
            return false;
        }

        if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
            alert("Please enter a valid date");
            return false;
        }
        return true;
    }
</script>
<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <table width="100%" >
    <tr>
    <td>
    
    
 <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Tyre</strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Mount/Dismount Tyre </strong></font>&nbsp;</td>
        </tr>
       <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
       <%-- <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>--%>
    </table>  
      
</td>
    </tr>
    <tr>
    
    <td>
    
    
 <br />
                <br />
    
    
     <table border="0" class="boxbg" cellpadding="4" cellspacing="1" width="800px"  >
             <%--  <tr bgcolor="white">
                      <td style="height: 14px" colspan="4">
                          <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label>
                      </td>
                  </tr>--%>
                  <tr bgcolor="white">
                      <td >
                          <asp:Label ID="Label1" runat="server" Text="Enter Tyre No. :"></asp:Label></td>
                      <td >
                          <asp:TextBox ID="txtTyreNo" runat="server" CssClass="input" AutoCompleteType="Office" Width="103px" ></asp:TextBox>
                          <asp:Button ID="btnPopupTyre" runat="server" Text="..." />
                         
                          
                          <%-- <asp:AutoCompleteExtender ID="au" runat="server">
              <asp:AutoCompleteProperties Enabled="true" MinimumPrefixLength="1" ServiceMethod="GetTyreNumber"
               ServicePath="~/services/AutoComplet.asmx" TargetControlID="txtTyreNo" />
              
              </asp:AutoCompleteExtender>--%>
                          
                          
                           
                          
                          
                      </td>
                      <td >
                          <asp:Label ID="Label2" runat="server" Text="Tyre Size :"></asp:Label></td>
                      <td >
                          <asp:TextBox ID="txtTyreSize" runat="server" BorderStyle="None" ></asp:TextBox></td>
                  </tr>
                  <tr bgcolor="white">
                      <td  >
                          <asp:Label ID="Label5" runat="server" Text="Tyre Pattern :"></asp:Label></td>
                      <td  >
                          <asp:TextBox ID="txtTyrePattern" runat="server" BorderStyle="None" ></asp:TextBox></td>
                      <td  >
                          <asp:Label ID="Label3" runat="server" Text="Tyre Position :"></asp:Label></td>
                      <td  >
                          <asp:TextBox ID="txtTyrePosition" runat="server" BorderStyle="None" ></asp:TextBox></td>
                  </tr>
                  <tr bgcolor="white">
                      <td  >
                          <asp:Label ID="Label4" runat="server" Text="Manufacturer :"></asp:Label></td>
                      <td  >
                          <asp:TextBox ID="txtManufacturer" runat="server" BorderStyle="None" ></asp:TextBox></td>
                      <td  >
                          <asp:Label ID="Label7" runat="server" Text="Vehicle Number :"></asp:Label></td>
                      <td  >
                          <asp:TextBox ID="txtVehNumber" runat="server" BorderStyle="None" ></asp:TextBox></td>
                  </tr>
         <tr bgcolor="white">
             <td >
                 <asp:Label ID="Label12" runat="server" Text="Date :"></asp:Label></td>
             <td colspan="3" >
                 <asp:TextBox ID="tb_Date" runat="server" BorderStyle="Groove" Columns="6" CssClass="input"
                     MaxLength="10" Text='<%#Eval("RemouldDate")%>' Width="60px" onblur= "javascript:ValidateDate(this)" >
                     </asp:TextBox>
                     <%--<asp:Image ID="img_Calendar" runat="server" BackColor="White" BorderColor="White" ForeColor="White"
                         ImageUrl="~/cal/cal.gif" />--%>
                         <ajaxToolkit:CalendarExtender ID="calExtenderEndDt" 
            		                   Format="dd/MM/yyyy"
                    		           TargetControlID="tb_Date"   runat="server" />
                         </td>
            
         </tr>
         <tr bgcolor="white">
             <td >
                 <asp:Label ID="Label14" runat="server" Text="Total Labour Hours :"></asp:Label></td>
             <td >
                 <asp:TextBox ID="txtTotalLabourHours"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  Width="75px" style="text-align:right" runat="server" CssClass="input"></asp:TextBox></td>
             <td >
                 <asp:Label ID="Label15" runat="server" Text="Total Labour Cost :"></asp:Label></td>
             <td >
                <asp:TextBox ID="txtTotalLabourCost"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  Width="75px" style="text-align:right" runat="server" CssClass="input"></asp:TextBox>
                 <asp:HiddenField ID="hfPosCategory" runat="server" />
                 <asp:HiddenField ID="hfTruckTrailer" runat="server" />
                 <asp:HiddenField ID="hfVehCate" runat="server" />
             </td>
         </tr>
         <tr bgcolor="white">
             <td >
                 <asp:Label ID="Label16" runat="server" Text="Current Vehicle Odometer Reading:"></asp:Label></td>
            <td >
                <asp:TextBox ID="txtCurrentKMRead" onfocus="this.blur()" Text="0.00" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="None"  runat="server"></asp:TextBox>
            </td>
             <td  >
                 <asp:Label ID="Label17" runat="server" Text="Manual Vehicle Odometer Reading :"></asp:Label></td>
             
             <td >
                 <asp:TextBox ID="txtManualKMRead" onblur="javascript:checkManualVehicleOdometerReading(this);"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  Width="75px" style="text-align:right" runat="server" CssClass="input"></asp:TextBox></td>             
                  </td>
         </tr>
                  <tr bgcolor="white">
                      <td colspan="4">
                          <asp:Panel ID="pnlMountTyre" runat="server" BackColor="Transparent"
                              Height="70px" Width="100%" Visible="True" BorderStyle="None" Font-Bold="True">
                              <table class="boxbg" cellpadding="1" cellspacing="1" style="width: 100%">
                                  <tr bgcolor="white">
                                      <td style="width: 25%;">
                          <asp:Label ID="Label6" runat="server" Text="Select Vehicle No. :" Font-Bold="False"></asp:Label></td>
                                      <td style="width: 75%; text-align: left;">
                          <asp:TextBox ID="txtVehNo" runat="server" CssClass="input" 
                              Width="130px" OnTextChanged="txtVehNo_TextChanged"></asp:TextBox><asp:Button ID="btnPopupVehno" runat="server" Text="..."
                                  Width="21px" /><asp:HiddenField ID="hfkm" runat="server" />
                          <asp:HiddenField ID="hfVehIntId" runat="server" />
                                      </td>
                                  </tr>
                                  <tr bgcolor="white">
                                      <td style="width: 25%">
                                          <asp:Label ID="Label13" runat="server" Font-Bold="False" Text="Current KM. :"></asp:Label></td>
                                      <td style="width: 75%; text-align: left">
                                          <asp:TextBox ID="txtKM" runat="server" BorderStyle="None" Width="109px"></asp:TextBox></td>
                                  </tr>
                                  <tr bgcolor="white">
                                      <td style="width: 25%;">
                                          <asp:Label ID="Label9" runat="server" Text="New Tyre Position :" Font-Bold="False"></asp:Label></td>
                                      <td style="width: 75%; text-align: left;">
                                          <asp:DropDownList ID="ddlTyrePosition" runat="server" Width="119px">
                                          </asp:DropDownList></td>
                                  </tr>
                                  <tr bgcolor="white">
                                    <td style="width: 25%;">
                                          <asp:HiddenField ID="hfTyreId" runat="server" />
                                    </td>
                                      <td style="width: 75%; text-align: right;">
                                        <asp:Button ID="btnMount" runat="server" OnClientClick="javascript:return ValidateMountTyre()" Text="Mount" OnClick="btnMount_Click" /></td>
                                  </tr>
                              </table>
                          </asp:Panel>
                          <asp:Panel ID="pnlDismountTyre" runat="server" BackColor="Transparent"
                              Height="110px" Width="100%" Visible="True" Font-Bold="True" BorderStyle="None">
                              <table class="boxbg" cellpadding="1" cellspacing="1" style="width: 100%">
                                  <tr bgcolor="white">
                                      <td style="width: 25%;">
                                          <asp:Label ID="Label8" runat="server" Text="Reason for Dismount:" Font-Bold="False"></asp:Label></td>
                                      <td style="width: 75%;"><asp:DropDownList ID="ddlTyreDismountReason" runat="server" Width="276px">
                                      </asp:DropDownList></td>
                                  </tr>
                                  <tr bgcolor="white">
                                      <td style="width: 25%;">
                                          <asp:Label ID="Label10" runat="server" Text="Remark :" Font-Bold="False"></asp:Label></td>
                                      <td style="width: 75%;">
                                          <asp:TextBox ID="txtRemark" runat="server" Width="274px"></asp:TextBox></td>
                                  </tr>
                                  <tr bgcolor="white">
                                      <td style="width: 25%">
                                          <asp:Label ID="Label11" runat="server" Text="Put Away Location :" Font-Bold="False"></asp:Label></td>
                                      <td style="width: 75%">
                                          <asp:DropDownList ID="ddlLocation" runat="server" Width="163px">
                                          </asp:DropDownList></td>
                                  </tr>
                                  <tr bgcolor="white">
                                      <td style="width: 25%">
                          </td>
                                      <td style="width: 75%; text-align: right;">
                          <asp:Button ID="btnDismount" runat="server" OnClientClick="javascript:return ValidateDismountTyre()" Text="Dismount" OnClick="btnDismount_Click"/></td>
                                  </tr>
                              </table>
                          </asp:Panel>
                      </td>
                  </tr>
              </table>
              </td>
    </tr>
    </table>
        </ContentTemplate>
    </asp:UpdatePanel>
  
</asp:Content>
