<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TyreScrap.aspx.cs" Inherits="Tyre_Scrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
<script src="../../images/DateControl.js" language="javascript"  type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
<script language="javascript" type="text/javascript">
var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();

var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

var FinYear="<%=Session["FinYear"]%>"
var FinYear_to=parseInt(FinYear)+1
	
if(FinYear_to<10)
{
    FinYear_to="0"+FinYear_to
}
var FinYear_fromdate="01/04/"+FinYear
var FinYear_todate="31/03/"+FinYear_to
var Sle_finyear=FinYear+"-"+FinYear_to


function validFloat(event, txtid) {
    var tb = document.getElementById(txtid);
    var txt = tb.value;
    if (event.keyCode == 13)
        return true;

    if (event.keyCode == 46)
        if (txt.indexOf('.') != -1)
        event.keyCode = 0;

    if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
    { event.keyCode = 0; return false; }
} 

</script>
<script language="javascript">
    var controlIdPrefix = "ctl00_MyCPH1_";
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkOdoReader(txtOdometerRead)
    {
        if (isNaN(txtOdometerRead.value)) 
        {
            alert("Enter Odometer Reading in numeric!!!"); 
            txtOdometerRead.value = ""; 
            txtOdometerRead.focus();    
            return false;
        }
    }
    function FillTyreDetails(row_Index,tb_Tyre_No,hfTyreid,tb_Tyre_MFG,tb_tyre_Model,tb_Tyre_Cost,tb_Tyre_Purchase_KM,tb_Current_KM,tb_Tread_Depth_Read)
    {
        var lbl_Error=document.getElementById(controlIdPrefix + "lbl_Error");
        
        var currentTime = new Date()
        var str_Index = "";
        if (tb_Tyre_No.value == "")
        {
            tb_Tyre_No.value="";
            hfTyreid.value="";
            tb_Tyre_MFG.value="";
            tb_tyre_Model.value="";
            tb_Tyre_Cost.value="";
            tb_Tyre_Purchase_KM.value="";
            tb_Current_KM.value="";
            tb_Tread_Depth_Read.value="";
            lbl_Error.innerText="";            
            return;
        }
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvScrap").rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (row_Index == intIndex - 2)
            {
                continue;
            }
            if (document.getElementById("ctl00_MyCPH1_gvScrap_ctl" + str_Index + "_tb_Tyre_No").value == tb_Tyre_No.value)
            {
                lbl_Error.innerText="This Tyre No is already exist at row " + (intIndex - 1);
                tb_Tyre_No.value = "";
                tb_Tyre_No.focus();
                return;
            }
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
                        lbl_Error.innerText = "Invalid Tyre Number";
                        hfTyreid.value="";
                        tb_Tyre_MFG.value="";
                        tb_tyre_Model.value="";
                        tb_Tyre_Cost.value="";
                        tb_Tyre_Purchase_KM.value="";
                        tb_Current_KM.value="";
                        tb_Tread_Depth_Read.value="";
                        tb_Tyre_No.focus();
                    }
                    else
                    {
                        if(returnValue[8]=="In Transit")
                        {
                            lbl_Error.innerText="Tyre number " + tb_Tyre_No.value + " is attached with Vehicle Number " + returnValue[9] + ". And This Vehicle is In Transit, hence Tyre scrap can not be done.";
                            hfTyreid.value="";
                            tb_Tyre_MFG.value="";
                            tb_tyre_Model.value="";
                            tb_Tyre_Cost.value="";
                            tb_Tyre_Purchase_KM.value="";
                            tb_Current_KM.value="";
                            tb_Tread_Depth_Read.value="";
                            tb_Tyre_No.focus();  
                            return false;
                        }
                        else
                        {
                            if(returnValue[10]=="Mounted")
                            {
                                lbl_Error.innerText="Tyre number " + tb_Tyre_No.value + " is mounted, hence Tyre scrap can not be done.";
                                hfTyreid.value="";
                                tb_Tyre_MFG.value="";
                                tb_tyre_Model.value="";
                                tb_Tyre_Cost.value="";
                                tb_Tyre_Purchase_KM.value="";
                                tb_Current_KM.value="";
                                tb_Tread_Depth_Read.value="";
                                tb_Tyre_No.focus();
                                return false;
                            }
                            else
                            {
                                if(returnValue[10]=="Scrapped")
                                {
                                    lbl_Error.innerText="Tyre " + tb_Tyre_No.value + " was already Scrapped.";
                                    hfTyreid.value="";
                                    tb_Tyre_MFG.value="";
                                    tb_tyre_Model.value="";
                                    tb_Tyre_Cost.value="";
                                    tb_Tyre_Purchase_KM.value="";
                                    tb_Current_KM.value="";
                                    tb_Tread_Depth_Read.value="";
                                    tb_Tyre_No.focus();
                                    return false;
                                }
                                else
                                {
                                    hfTyreid.value=returnValue[1];
                                    tb_Tyre_MFG.value=returnValue[2];
                                    tb_tyre_Model.value=returnValue[3];
                                    tb_Tyre_Cost.value=returnValue[4];
                                    tb_Tyre_Purchase_KM.value=returnValue[5];
                                    tb_Current_KM.value=returnValue[6];
                                    tb_Tread_Depth_Read.value=returnValue[7];
                                    lbl_Error.innerText="";
                                }
                            }
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=FillTyreDetailsForTyreScrap&datetime="+currentTime+"&TyreNo=" + tb_Tyre_No.value, false);
            xmlHttpRequest.send(null);
        }	
    }
        
    function CheckVendorName(tb_Part_vendor,hfVendorCode)
    {
        //alert("1");
        var currentTime = new Date()

        if(tb_Part_vendor.value == "")
        {    
           tb_Part_vendor.value="";  
           return 
        }  
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    //alert(xmlHttpRequest.responseText);
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {   
                        alert("Invalid Vendor Name");             
                        //txtDriver1.value="";  
                        tb_Part_vendor.focus();
                        return false;
                    } 
                    else
                    {
                        hfVendorCode.value=returnValue[2];
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetVendorName&datetime="+currentTime+"&VENDORNAME=" + tb_Part_vendor.value, false);
            xmlHttpRequest.send(null);
        }   
    }
    function checkSubmit()
    {
        var tot_rows=document.getElementById(controlIdPrefix + "gvScrap").rows.length;
        var tyreId="";
        var TYID1="";
        var TYID2="";
        var txtOdometerRead="";
        var txtOdoReadDate="";
        var ddlReason="";
        if(tot_rows>0)
        {
            for(i=0;i< tot_rows-1;i++)
            {  
                j=i+2
                var pref="";
                if(j<10)
                {
                    pref = "ctl00_MyCPH1_gvScrap_ctl0" + j + "_";
                }                                       
                else
                {         
                    pref = "ctl00_MyCPH1_gvScrap_ctl" + j + "_";
                }
                
                tb_Tyre_No=document.getElementById(pref + "tb_Tyre_No");
                tb_Vehicle_No=document.getElementById(pref + "tb_Vehicle_No");
                tb_Tyre_MFG=document.getElementById(pref + "tb_Tyre_MFG");
                tb_tyre_Model=document.getElementById(pref + "tb_tyre_Model");
                tb_Cur_KM=document.getElementById(pref + "tb_Cur_KM");
                tb_Current_KM=document.getElementById(pref + "tb_Current_KM");
                tb_Tread_Depth_Read=document.getElementById(pref + "tb_Tread_Depth_Read");
                tb_Scrap_Date=document.getElementById(pref + "tb_Scrap_Date");
                tb_Scrap_Vendor=document.getElementById(pref + "tb_Scrap_Vendor");
                tb_Scrap_Value=document.getElementById(pref + "tb_Scrap_Value");
                tb_Remarks=document.getElementById(pref + "tb_Remarks");
                
                if(tb_Tyre_No.value!="")
                {
                    if(tb_Scrap_Vendor.value=="")
                    {
                        alert("Enter Scrap Vendor.");
                        tb_Scrap_Vendor.focus();
                        return false;
                    }
                    
                }
                
//                if(tb_Vehicle_No.value=="")
//                {
//                    alert("Enter Vehicle Number!!!");
//                    document.getElementById(pref + "txtVehicleNo").focus();
//                    return false;
//                }
//                
//                if(tb_Tyre_MFG.value=="")
//                {
//                    alert("Enter New Odometer Reading!!!");
//                    document.getElementById(pref + "txtOdometerRead").focus();
//                    return false;
//                }
//                if(txtOdoReadDate=="")
//                {
//                    alert("Enter Odometer Date!!!");
//                    document.getElementById(pref + "txtOdoReadDate").focus();
//                    return false;
//                }
//                if(ddlReason=="0")
//                {
//                    alert("Select Odometer Reason!!!");
//                    document.getElementById(pref + "ddlReason").focus();
//                    return false;
//                }
                
                
//                for(k=0;k<tot_rows-1;k++)
//                {  
//                    if(i!=k)
//                    {
//                        m=k+2
//                        var pref="";
//                        if(j<10)
//                        {
//                            pref = "ctl00_MyCPH1_gvScrap_ctl0" + m + "_";
//                        }                                       
//                        else
//                        {         
//                            pref = "ctl00_MyCPH1_gvScrap_ctl" + m + "_";
//                        }    
//                        TYID2=document.getElementById(pref + "tb_tyre_no").value ;
//                        if(TYID1==TYID2)
//                        {
//                            alert("Please Select different Tyre ID in each row!");
//                            document.getElementById(pref + "tb_tyre_no").focus();
//                            return false;
//                        }
//                    }
//                }
            }
        }
    }
    
    function CheckKM(tb_Capture_KM)
    {
        if (isNaN(tb_Capture_KM.value)) 
        {
            alert("Invalid KM"); 
            tb_Capture_KM.value = ""; 
            tb_Capture_KM.focus();
            return false;
        }
    }
</script>

<script language="javascript">
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
	    <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
	    <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
	    <img src="../../Images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>
<div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div>
<div >
<div >
    <table cellspacing="1" style="width: 40%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Tyre Scrap Module</asp:Label>
                
            </td>
        </tr>
    </table>
<hr>
<br>
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="25%">
        <tr  bgcolor="white">   
            <td width="50%" class="blackfnt"  colspan="2"><strong>Enter Row No *</strong></td>
            <td width="50%" align="left" class="blackfnt" colspan="2">
                <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" Width="15px"  MaxLength="2"
                             AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    
 <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="100%">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="text-align: left" >
                <asp:Label ID="lbl_Error" CssClass="redfnt"  runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="text-align: left" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                    
                    <asp:GridView ID="gvScrap" BorderWidth="0" CellSpacing="1"
                                runat="server" AutoGenerateColumns="false" Width="1200px" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                OnRowDataBound="gvScrap_RowDataBound"
                                 SelectedIndex="1" >
                            <Columns>
                            
                                <asp:TemplateField HeaderText="Sr.<br>No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px"  HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Tyre Number">
                                   <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_Tyre_No"  BorderStyle="Groove"   CssClass="input" Width="90px" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnPopupTyre" runat="server" Text="..." />
                                        <asp:HiddenField ID="hfTyreid"  runat="server"></asp:HiddenField>
                                        
                                    </ItemTemplate>
                                     <ItemStyle Width="120px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Tyre<br>Manufacturer">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_Tyre_MFG" BorderStyle="None" Width="60px" runat="server" onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="Tyre Model">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_tyre_Model" BorderStyle="None"   Width="60px" runat="server" onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                
                                 <asp:TemplateField HeaderText="Tyre Cost">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_Tyre_Cost" BorderStyle="None"  Width="60px" runat="server" onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="Tyre Purchase<br>KM">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_Tyre_Purchase_KM" BorderStyle="None" Width="60px" runat="server" onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Current<br>KM Read">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_Current_KM" BorderStyle="None"  Width="60px" runat="server" onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                  <asp:TemplateField HeaderText="Last Tread<br>Depth Reading">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_Tread_Depth_Read" BorderStyle="None"  Width="60px" runat="server" onfocus="this.blur()"></asp:TextBox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="Scrap Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox id="tb_Scrap_Date" runat="server" BorderStyle="Groove"  Columns="6" Width="60px" CssClass="input"   MaxLength="10" onblur= "javascript:ValidateDate(this)" ></asp:textbox>
	                                    <asp:Image id="img_cal" runat="server" ImageUrl="~/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:Image>       
                                    </ItemTemplate>
                                     <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Scrap Vendor">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                            <td>
                                                 <asp:TextBox id="tb_Scrap_Vendor" runat="server" BorderStyle="Groove" Columns="6" Width="100px" CssClass="input" ></asp:textbox>
                                                <asp:HiddenField ID="hfVendorCode" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btn_PopUp1" runat="server" Text="..." /> 
                                            </td>
                                        </tr>
                                      </table>                                         
                                       </ItemTemplate>
                                     <ItemStyle Width="150px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                
                                
                                  <asp:TemplateField HeaderText="Estimated Scrap <br>Value (Rs.)">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                    <asp:TextBox id="tb_Estimated_Scrap_Value" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  MaxLength="10"
                                      BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"Estimated_Scrap_Value") %>' Width="60px" CssClass="input" Style="text-align: right"></asp:textbox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="Actual Scrap <br>Value (Rs.)">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                    <asp:TextBox id="tb_Scrap_Value" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" MaxLength="10"
                                    BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"Scrap_Value") %>' Width="60px" CssClass="input" Style="text-align: right"></asp:textbox>
                                    </ItemTemplate>
                                     <ItemStyle Width="70px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemStyle HorizontalAlign="Left" Width="30%" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_Remarks" BorderStyle="Groove" CssClass="input"  runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                     <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
                   </td>
        </tr>
       
        <tr bgcolor="white">
        <td class="blackfnt" colspan="1" style="vertical-align: middle; text-align: center; height: 25px;">
            <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return checkSubmit()"  OnClick="btn_Submit_Click" />
        </tr>
    </table>

    <br />

    <br />
    
    <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
</div>
</asp:Content>