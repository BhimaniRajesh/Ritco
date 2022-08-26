<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="frmVehicleTransfer.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmVehicleTransfer" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script src="../../../images/DateControl.js" language="javascript"  type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
<script language="javascript" type="text/javascript" src="AJAX_Validator/VehicleTransfer.js"> </script>
<script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

<script language="javascript" type="text/javascript">
var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();

//function nwOpen()
//{
//    window.open("Popup-Vehicle.aspx?","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
//    return false;
//}

function isDate(dtStr)
{
    var daysInMonth = DaysArray(12)
    var pos1=dtStr.indexOf(dtCh)
    var pos2=dtStr.indexOf(dtCh,pos1+1)
    var strDay=dtStr.substring(0,pos1)
    var strMonth=dtStr.substring(pos1+1,pos2)
    var strYear=dtStr.substring(pos2+1)
    strYr=strYear
    if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
    if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
	    if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
    }
	
    month=parseInt(strMonth)
    day=parseInt(strDay)
    year=parseInt(strYr)
    if (pos1==-1 || pos2==-1){
	    alert("The date format should be : dd/mm/yyyy")
	    return false
    }
    if (strMonth.length<1 || month<1 || month>12){
	    alert("Please enter a valid month")
	    return false
    }
    if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
	    alert("Please enter a valid day")
	    return false
    }
    if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
	    alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
	    return false
    }
	 
    if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
	    alert("Please enter a valid date")
	    return false
    }
    return true
} 
function stripCharsInBag(s, bag)
{
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}
function isInteger(s){
    var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}
function ValidateDate(obj)
{
  if (obj.value!="")
  {
    if (isDate(obj.value)==false)
    {
        obj.focus();
        return false;
    }
    return true;
  }
}

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

</script>
<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
	    <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
	    <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
	    <img src="../../../images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>

<div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div>
    <table cellspacing="1" style="width: 200px">
        <tr style="background-color: white">
            <td align="left" style="height: 18px; width: 355px;">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Vehicle Transfer Module</asp:Label>
                
            </td>
        </tr>
    </table>
    <br />
    
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="25%">
        <tr  bgcolor="white">   
            <td width="40%" class="blackfnt"  colspan="2"><strong>Enter Row No *</strong></td>
            <td width="60%" align="left" class="blackfnt" colspan="2">
                <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>

 <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
    <ContentTemplate>
     <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="1000px">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
              
                         <asp:GridView ID="gvVehicleTransfer" runat="server" OnRowDataBound="gvVehicleTransfer_RowDataBound"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="1000px"
                            DataKeyNames="VehicleNo">
                            
                            <Columns>
                                <asp:TemplateField HeaderText="Sr. No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />                             
                                    <ItemTemplate>
                                       <%-- <asp:CheckBox ID="CheckBox1" Checked="false" Text="<%#Container.DataItemIndex + 1%>" runat="server"/>--%>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtVehNo" BorderStyle="Groove" CssClass="input" Width="90px" runat="server"></asp:TextBox>  
                                       <%-- <atlas:AutoCompleteExtender ID="au" runat="server" DropDownPanelID="pnlDropdown" >
                                        <atlas:AutoCompleteProperties Enabled="true" MinimumPrefixLength="1" ServiceMethod="GetVehNo"
                                                 ServicePath="~/GUI/services/WebService.asmx" TargetControlID="txtVehNo" />     
                                        </atlas:AutoCompleteExtender>--%>
                                        
                                        <ajaxToolkit:AutoCompleteExtender
                                        runat="server" 
                                        ID="autoComplete5" 
                                        TargetControlID="txtVehNo"
                                        ServicePath="~/GUI/services/WebService.asmx" 
                                        ServiceMethod="GetVehNo"
                                        MinimumPrefixLength="1" 
                                        CompletionInterval="1000"
                                        EnableCaching="true"
                                        CompletionSetCount="20"
                                        CompletionListCssClass="autocomplete_completionListElement" 
                                        CompletionListItemCssClass="autocomplete_listItem" 
                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        DelimiterCharacters=";, :">
                                        </ajaxToolkit:AutoCompleteExtender> 
                                        
                                       <%--<asp:Panel ID="pnlDropdown" Height="200px" ScrollBars="Vertical" BackColor="transparent" runat="server" BorderStyle="Inset" BorderWidth="1px" Direction="LeftToRight" Font-Names="Verdana" Font-Overline="False" Font-Size="8pt" Font-Underline="False" HorizontalAlign="Left"></asp:Panel>--%>
                                        <asp:Button ID="btnPopupVehNo" runat="server" Text="..." />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="200px" />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Vehicle<br>Internal No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                        <%-- <asp:Label ID="lblVehInternalNo" runat="server" Text=""></asp:Label>--%>
                                         <asp:TextBox ID="txtVehInternalNo" onfocus="this.blur()" style="text-align:right" BorderStyle="None" Width="65px" runat="server"></asp:TextBox>  
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                               
                                <asp:TemplateField HeaderText="Current<br>Controlling<br>Location">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                            <%--<asp:Label ID="lblCurrContlLoc" runat="server" Text=""></asp:Label> --%>
                                            <asp:TextBox ID="txtCurrContlLoc" onfocus="this.blur()" BorderStyle="None" Width="65px" runat="server"></asp:TextBox>    
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Left" />
                                </asp:TemplateField>
                               
                                 <asp:TemplateField HeaderText="Current KM<br>Reding">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                            <%--<asp:Label ID="lblCurrKmRead" runat="server" Text=""></asp:Label> --%>
                                            <asp:TextBox ID="txtCurrKmRead" onfocus="this.blur()" style="text-align:right" BorderStyle="None" Width="65px" runat="server"></asp:TextBox>       
                                    </ItemTemplate>
                                     <ItemStyle Width="150px" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="New Vehicle<br>No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:textbox id="txtNewVehNo" runat="server" Width="90px" BorderStyle="Groove" CssClass="input"></asp:textbox>
                                    </ItemTemplate>
                                     <ItemStyle Width="150px" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="New<br>Controlling<br>Branch">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:textbox id="txtNewContlBranch" BorderStyle="Groove" runat="server" Width="65px" CssClass="input"></asp:textbox>
                                        <%--<atlas:AutoCompleteExtender ID="au1" runat="server" DropDownPanelID="pnlDropdown1">
                                        <atlas:AutoCompleteProperties Enabled="true" MinimumPrefixLength="1" ServiceMethod="GetLocCode"
                                                 ServicePath="~/GUI/services/WebService.asmx" TargetControlID="txtNewContlBranch" />     
                                        </atlas:AutoCompleteExtender>--%>
                                        
                                         <ajaxToolkit:AutoCompleteExtender
                                            runat="server" 
                                            ID="AutoCompleteExtender1" 
                                            TargetControlID="txtNewContlBranch"
                                            ServicePath="~/GUI/services/WebService.asmx" 
                                            ServiceMethod="GetLocCode"
                                            MinimumPrefixLength="1" 
                                            CompletionInterval="1000"
                                            EnableCaching="true"
                                            CompletionSetCount="20"
                                            CompletionListCssClass="autocomplete_completionListElement" 
                                            CompletionListItemCssClass="autocomplete_listItem" 
                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                            DelimiterCharacters=";, :">
                                        </ajaxToolkit:AutoCompleteExtender>
                                        
                                        <%--<asp:Panel ID="pnlDropdown1" Height="200px" ScrollBars="Vertical" BackColor="transparent" runat="server" BorderStyle="Inset" BorderWidth="1px" Direction="LeftToRight" Font-Names="Verdana" Font-Overline="False" Font-Size="8pt" Font-Underline="False" HorizontalAlign="Left"></asp:Panel>--%>
                                        <asp:Button ID="btnPopupLoc" runat="server" Text="..." />
                                    </ItemTemplate>
                                     <ItemStyle Width="150px" HorizontalAlign="Left" />
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="Vehicle Transfer<br>Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:TextBox id="txtVehTransferDt" runat="server" BorderStyle="Groove" onblur="javascript:ValidateDate(this)" Width="80px" CssClass="input"></asp:TextBox>
                                        <asp:Image ID="img_cal" ImageUrl="~/GUI/images/calendar.jpg"  runat="server" />
                                          <%--<a href="#" onclick="cal.select(ctl00_MyCPH1_gvJobOrderCancel_ctl02_txtCancellation_Date,'anchor22','dd/MM/yyyy'); return false;" id="a1" name="anchor22">
                                          <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>--%>
                                    </ItemTemplate>
                                     <ItemStyle Width="150px" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                            </Columns>
                        </asp:GridView>
                    
                   </td>
        </tr>
        </table>
         </ContentTemplate>
  </asp:UpdatePanel>
     
    <table id="Table1" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="1000px">   
    <tr bgcolor="white">
    <td colspan="4" align="left"  style="background-color: white"> 
    <p align=center>                    
       <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return CheckSubmit()" OnClick="btn_Submit_Click" />
     </p>
    </td>
    </tr>   
    </table>

        <tr bgcolor="white" align="center">
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
        </tr>
        <tr bgcolor="white" align="center">
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Submit" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
        </tr>

</asp:Content>

