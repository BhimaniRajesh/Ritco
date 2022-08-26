<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmPincodeCriteria.aspx.cs" Inherits="GUI_admin_PinCodeMaster_FrmPincodeCriteria"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    var mode = "<%=mode%>"
    var edstate = "<%=edstate%>"
    var edcity = "<%=edcity%>"
    var edpin = "<%=edpin%>"
 function IsText(sText)
    {
       var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
       var IsText=true;
       var Char;

       for (i = 0; i < sText.length && IsText == true; i++) 
       { 
          Char = sText.charAt(i); 
          
          if (ValidChars.indexOf(Char) == -1) 
          {
            IsText = false;
          }
       }
       
       return IsText;
    }
    function IsNumber(sText)
    {
       //debugger
       var ValidChars = "0123456789";
       var IsNumber=true;
       var Char;

       for (i = 0; i < sText.length && IsNumber == true; i++) 
       { 
          Char = sText.charAt(i); 
          
          if (ValidChars.indexOf(Char) == -1) 
          {
            IsNumber = false;
          }
       }
       return IsNumber;
    }
     function abc(index,val,ctl)
    {
      
//       for(i=0;i<str.length;i++)
//       {
//            if(val.value==str[i] && val.value != document.getElementById(ctl).value)
//            {
//                alert("Name already exists !!!")
//                val.focus()
//                break;
//                //return false;
//            }
//       }
     
    }
     function trimAll(strValue) 
        {
            //Trimming left most white space characters
            while (strValue.substring(0,1) == ' ')
            {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length-1, strValue.length) == ' ')
            {
                strValue = strValue.substring(0, strValue.length-1);
            }
            
            return strValue;
        }
    function abc(val)
    {
       //debugger
//       val.value = val.value.toUpperCase()
//       for(i=0;i<str.length;i++)
//       {
//            if(val.value==str[i])
//            {
//                alert("Name already exists !!!")
//                val.focus()
//                break;
//            }

//       }
     
    }
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
	var p
	function doWork() 
	{
	    if (doc.readyState == 4) {
	     //alert(doc.responseText)
	           //debugger
	           if (doc.responseText.split("|")[0]!="OK")
	           {
	                alert(doc.responseText)
	                p=false
	                return false
	                
	           }
	           else
	           {
	                p=true
                    return true
	           }
	    }
	}
    
    function validatedata(objstate,objcity,objpin)
    {
                    //debugger
                    if(objstate.value == "--select one--")
                    {
                        alert("Please Select at least one state");
                        objstate.focus();
                        return false;
                    }
                    else if(objcity.value == "--select one--")
                    {
                        alert("Please Select at least one City");
                        objcity.focus();
                        return false;
                    }
                    else if(objpin.value == "")
                    {
                        alert("Please Enter Pincode");
                        objpin.focus();
                        return false;
                    }
                    objpin.value = trimAll(objpin.value);
                    var str = objpin.value
                    if (str.length != 6)
                    {
                        alert("Please Enter Pincode in 6 digits Only !!")
                        objpin.focus();
                        return false
                    }
                    var checkpin = IsNumber(objpin.value)
                    //debugger
                    if (checkpin == false)
                    {
                        alert("Please Enter Valid Numeric Pincode !!")
                        objpin.focus();
                        return false
                    }
                    createXMLHTTPObject();
                    if (doc)
				            {        
				                arg=new Date()
					            doc.onreadystatechange = doWork; 
					            doc.open("GET", "dyn_combo.aspx?state=" + objstate.value + "&city=" + objcity.value + "&pin=" + objpin.value + "&edstate="+ edstate +"&edcity="+ edcity +"&edpin="+ edpin +"&mode="+ mode +"&RandText="+ arg, false);
					            doc.send(null);
				            }
				    //debugger
				    if (p==false)
				    {
				        return false
				    }
				    else
				    {
				        return true
				    }
      }
    </script>

    <div align="left" style="width: 10in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left">
                                <a><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a><font class="blklnkund">
                                    <strong>Administrator </strong></font></a>&gt; <a href="../company_structure.aspx"><font
                                        class="blklnkund"><strong>Company Structure</strong></font></a> <font class="bluefnt">
                                            <strong>&gt;PinCode Master</strong> </font>
                            </td>
                            <td align="right">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="39%" valign="top">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td height="300" valign="top">
                                                        <table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="boxbg">
                                                            <tr class="bgbluegrey">
                                                                <td colspan="2">
                                                                    <div align="center">
                                                                        <font class="blackfnt"><b>Add PinCode Master</b></font></div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" bgcolor="#FFFFFF">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                                                                        <tr>
                                                                            <td width="116" nowrap style="height: 25px">
                                                                                <div align="left">
                                                                                    <b><font class="blackfnt">Select State</font></b></div>
                                                                            </td>
                                                                            <td width="440">
                                                                                <div align="left">
                                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:DropDownList ID="cmbstate" AutoPostBack="true" runat="server" CssClass="blackfnt"
                                                                                                OnSelectedIndexChanged="cmbstate_SelectedIndexChanged">
                                                                                            </asp:DropDownList>
                                                                                        </ContentTemplate>
                                                                                    </asp:UpdatePanel>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="116" nowrap>
                                                                                <div align="left">
                                                                                    <b><font class="blackfnt">Select City</font></b></div>
                                                                            </td>
                                                                            <td width="440">
                                                                                <div align="left">
                                                                                    <asp:UpdatePanel ID="upLocationCode" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:DropDownList ID="cmbcity" runat="server" CssClass="blackfnt">
                                                                                            </asp:DropDownList>
                                                                                        </ContentTemplate>
                                                                                        <Triggers>
                                                                                            <asp:AsyncPostBackTrigger ControlID="cmbstate" EventName="SelectedIndexChanged" />
                                                                                        </Triggers>
                                                                                    </asp:UpdatePanel>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="116" nowrap>
                                                                                <div align="left">
                                                                                    <b><font class="blackfnt">Pin Code</font></b></div>
                                                                            </td>
                                                                            <td width="440">
                                                                                <div align="left">
                                                                                    <asp:TextBox ID="txtpincode" runat="server" MaxLength="6" Width="98px"></asp:TextBox>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2" height="22">
                                                                                <div align="right">
                                                                                    <asp:Button ID="btnListing" runat="server" Text="Go to for Listing" OnClick="btnListing_Click" />
                                                                                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click"
                                                                                        Text="Save" /></div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
