<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HolidayListingNew.aspx.cs" Inherits="GUI_admin_AirportMaster_AirportListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language ="javascript" type="text/javascript" >
var airportval="<%=holidaystr%>";
var tmptext="<%=tmptext%>";
var doc = null; 
var formobj;
var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;

	function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
	function doWork() {
	    if (doc.readyState == 4) {
	     //alert(doc.responseText)
	           
	           if (doc.responseText!="OK")
	           {
	            alert(doc.responseText)
	            formobj.value="";
	            formobj.focus();
	           }
	           // val=doc.responseText
				
				//MyDiv.innerHTML = doc.responseText;
				//document.form1.submit1.focus();
	    }
	}
	
 function abc(index,val,ctl)
    {
      
      //debugger
      //alert(str)
//      index = index-2
//    alert(index+1);
       for(i=0;i<str.length;i++)
       {
//            alert(i + "---" + index)
//            alert(i==index)
//            if (i==index)
//            {
//                continue;
//            }
//            alert(val.value + "---" + str[i])
//            alert(val.value==str[i])
            //ctl00$MyCPH1$GrdPaidFollow$ctl02$hiddenhdateadd
            //ctl00_MyCPH1_GrdPaidFollow_ctl02_hiddenhdateadd
            if(val.value==str[i] && val.value != document.getElementById(ctl).value)
            {
                alert("Holiday Already Given On This Date !!!")
                val.focus()
                break;
                //return false;
            }
       }
     
    }

        
        
        function airportcheck(obj,edittext)
        {

        formobj=obj
//        
//           
 //alert(loccodeval)
//           // debugger
//            if(obj.value.length<3 && obj.value.length>0)
//            {
//                alert("Invalid Airport Name Length")
//                obj.focus();
//                return false;
//            }
//            obj.value = obj.value.toUpperCase()
//            if (obj.value.toUpperCase()!="")
//            {
//                if(airportval.indexOf(obj.value.toUpperCase())!=-1 && obj.value != edittext.value)
//                {
//                    alert("Airport Name Already Exists !!")
//                    obj.focus();
//                    return false;
//                }
//            }
//alert(obj.value)
//alert(edittext.value)
obj.value = obj.value.toUpperCase()
                        if(obj.value!=edittext.value && obj.value!="")
                        {
                                createXMLHTTPObject();
                                //alert("hi.............0")
				            if (doc)
				            { 
				           // alert(obj.value)
				            arg=new Date()
					            doc.onreadystatechange = doWork; 
					            doc.open("GET", "dyn_combo.aspx?EditedAirport=" + obj.value + "&RandText="+arg, false);
					            doc.send(null);
					            //alert(chqno)
				            }
				           // alert("hi.............1")
				       }
        }
function ValidateDate(obj)
{
if (obj.value!="")
{
var dockdt=obj.value

if(dockdt.length<10)
{
alert("Please enter the date in dd/mm/yyyy format")
obj.focus();
return false;
}

if (isDate1(obj.value)==false)
{
obj.focus()
return false
}

return true
}
}
var months = new Array("","January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December");

        var dtCh= "/";
        var minYear=1900;
        var maxYear=2100;
        
        function isInteger(s)
        {
            for (var i = 0; i < s.length; i++)
            {   
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag)
        {
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (var i = 0; i < s.length; i++)
            {   
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }
            
            return returnString;
        }

        function daysInFebruary (year)
        {
	        // February has 29 days in any year evenly divisible by four,
            // EXCEPT for centurial years which are not also divisible by 400.
            return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
        }
        
        
        
function isDate1(dtStr)
{
var daysInMonth = DaysArray(12)
var pos1 = dtStr.indexOf(dtCh)
var pos2 = dtStr.indexOf(dtCh,pos1+1)
var strDay = dtStr.substring(0,pos1)
var strMonth = dtStr.substring(pos1+1,pos2)
var strYear = dtStr.substring(pos2+1)

strYr = strYear

if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)

for (var i = 1; i <= 3; i++)
{
if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
}

month = parseInt(strMonth)
day = parseInt(strDay)
year = parseInt(strYr)

if (pos1==-1 || pos2==-1)
{
alert("The date format should be : dd/mm/yyyy")
return false
}

if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
{
alert("Please enter a valid day")
return false
}

if (strMonth.length<1 || month<1 || month>12)
{
alert("Please enter a valid month")
return false
}

if (strYear.length != 4 || year==0 || year<minYear || year>maxYear)
{
alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
return false
}

if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false)
{
alert("Please enter a valid date")
return false
}

return true
}

function daysInFebruary (year)
{
// February has 29 days in any year evenly divisible by four,
// EXCEPT for centurial years which are not also divisible by 400.
return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n)
{
for (var i = 1; i <= n; i++)
{
this[i] = 31
if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
if (i==2) {this[i] = 29}
}

return this
}
</script> 
    
    <div align="center">
    <br />
    <div align="left">
    <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href="../miscellaneous.aspx"><font class="blklnkund"><b>Miscellaneous</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Holiday Master</b></font></div>
    <div align="right">  
        <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>
    <asp:GridView ShowFooter="true" ID="GrdPaidFollow" PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowEditing="GrdPaidFollow_RowEditing" OnRowCancelingEdit="GrdPaidFollow_RowCancelingEdit" OnRowUpdating="GrdPaidFollow_RowUpdating" OnRowDeleting="GrdPaidFollow_RowDeleting" OnRowCreated="GrdPaidFollow_RowCreated" OnRowDataBound="GrdPaidFollow_RowDataBound"> 
    <Columns>
     <asp:TemplateField HeaderText="State">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                
                <asp:Label ID="lblstateadd" Width="150" CssClass="blackfnt" runat="server" Text='<%# Eval("stnm") %>' ></asp:Label> 
        
                </ItemTemplate>
                <EditItemTemplate>
                <asp:Label ID="lblstatedit" Width="150" CssClass="blackfnt" runat="server" Text='<%# Eval("stnm") %>' ></asp:Label>                 
                <%--<asp:TextBox ID="txtgcode" Width="337" MaxLength="50"   runat="server" Text='<%# Eval("stnm") %>' ></asp:TextBox>--%>
                
                </EditItemTemplate> 
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Holiday">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                
                <asp:Label ID="lblhdate" Width="150" CssClass="blackfnt" runat="server" Text='<%# Eval("HDAY_DATE_103") %>' ></asp:Label> 
                <%--<asp:TextBox ID="txtgname" Width="337" MaxLength="50"   runat="server" Text='<%# Eval("airportcity") %>' ></asp:TextBox> --%>
                <asp:HiddenField ID="hiddenhdateadd" runat="server" Value='<%# Eval("HDAY_DATE_103") %>'/>
                </ItemTemplate>
                <EditItemTemplate>
                <asp:HiddenField ID="hiddenhdateedit" runat="server" Value='<%# Eval("HDAY_DATE_103") %>'/>
                <asp:TextBox ID="txthdate" Width="150" CssClass="blackfnt" MaxLength="50" runat="server" Text='<%# Eval("HDAY_DATE_103") %>' ></asp:TextBox>                 
                
                </EditItemTemplate> 
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Holiday Note">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                
                <asp:Label ID="lblnote" Width="150" CssClass="blackfnt" runat="server" Text='<%# Eval("hday_note") %>' ></asp:Label> 
                <%--<asp:TextBox ID="txtgname" Width="337" MaxLength="50"   runat="server" Text='<%# Eval("airportcity") %>' ></asp:TextBox> --%>
                </ItemTemplate>
                <EditItemTemplate>
                
                <asp:TextBox ID="txtnote" Width="150" CssClass="blackfnt" MaxLength="50" runat="server" Text='<%# Eval("hday_note") %>' ></asp:TextBox>                 
               <%--<asp:HiddenField  Value='<%# Eval("airportcity") %>'  ID="editAirport" runat="server" />--%>
                </EditItemTemplate> 
    </asp:TemplateField>
    
    <asp:TemplateField ItemStyle-Width="150">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Button Text="  Edit  " ID="CmdEdit" runat="server" CommandName="Edit" UseSubmitBehavior="false"/>  
                </ItemTemplate>
                <EditItemTemplate>
                <asp:Button Text="Update" ID="CmdUpdate" runat="server" CommandName="Update" UseSubmitBehavior="false"/>  
                <asp:Button Text="Cancel" ID="CmdCancel" runat="server" CommandName="Cancel" UseSubmitBehavior="false"/>  
                </EditItemTemplate> 
    </asp:TemplateField>  
    
    <asp:TemplateField ItemStyle-Width="75">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Button Text="Delete" Visible="false" ID="CmdDelete" runat="server" CommandName="Delete" UseSubmitBehavior="false"/>  
                <asp:Button Text="Delete" OnClientClick="return confirm('Are You Sure Want To Delete ?')"  ID="CmdDeleteExtern" OnClick="delairport"  runat="server"  UseSubmitBehavior="true"/>  
                </ItemTemplate>
                <FooterTemplate>
                <asp:Button Text="  Add  " ID="CmdAdd" runat="server" CommandName="Add" UseSubmitBehavior="true" PostBackUrl="~/GUI/admin/Holiday/HolidayAdd.aspx"/>  
                </FooterTemplate> 
    </asp:TemplateField>  
    
      
    </Columns> 
    </asp:GridView>
    </ContentTemplate> 
    </asp:UpdatePanel>       
    </div>
    </asp:Content>
