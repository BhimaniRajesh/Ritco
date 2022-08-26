<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="DocketEditFields.aspx.cs" Inherits="GUI_Operation_DocketEditFields_DocketEditFields" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="cntone" runat="server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
 function popupConsignor()
    {
       var hdnorgnloc=document.getElementById("ctl00_MyCPH1_hdnorgnloc");
        window.open("DataPopUp.aspx?poptp=party&code1=ctl00_MyCPH1_txtcsgncd&code2=ctl00_MyCPH1_txtcsgnnm&code3=" + hdnorgnloc.value,null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
    }
    
 function popupConsignee()
    {
       var hdndelloc=document.getElementById("ctl00_MyCPH1_hdndelloc");
        window.open("DataPopUp.aspx?poptp=party&code1=ctl00_MyCPH1_txtcsgecd&code2=ctl00_MyCPH1_txtcsgenm&code3=" + hdndelloc.value,null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
    }
    
function popupCSGNCity()
	{
	    window.open("DataPopUp.aspx?poptp=csgncity&code1=ctl00_MyCPH1_txtcsgncity&code2=",null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
	}
	
function popupCSGECity()
{
    window.open("DataPopUp.aspx?poptp=csgecity&code1=ctl00_MyCPH1_txtcsgecity&code2=",null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15");
}

	    
function submitClick()
{
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    if(hdnajaxstate.value=="1")
    {
        alert("Let Internal Processes Over...Try after Sometime or LogOn Again...");
        return false;
    }
    
    var txtone=document.getElementById("ctl00_MyCPH1_txtone");
    if(txtone.value=="")
    {
    
    }
    
    return true;
}




function emailCheck(id) {

    var txt=document.getElementById(id);

        if(txt.value=="")
            return false;
    
        var str=txt.value;
    
		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail ID");
		   txt.select();
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail ID");
		   txt.select();
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail ID");
		    txt.select();
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail ID");
		    txt.select();
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail ID");
		    txt.select();
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail ID");
		    txt.select();
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail ID");
		    txt.select();
		    return false
		 }

 		 return true					
	}




function partyTest(tp,loccode)
{
   var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";
    
    
    var txt,txtname;

    if(tp=="csgn")
    {
        txt=document.getElementById("ctl00_MyCPH1_txtcsgncd");
        txt.value=txt.value.toUpperCase();
        txtname=document.getElementById("ctl00_MyCPH1_txtcsgnnm");
    }
    else if(tp=="csge")
    {
        txt=document.getElementById("ctl00_MyCPH1_txtcsgecd");
        txt.value=txt.value.toUpperCase();
        txtname=document.getElementById("ctl00_MyCPH1_txtcsgenm");
    }
    
    if(txt.value=="")
    {
        hdnajaxstate.value="0";
        txtname.value="";
        return false;
    }

  
          
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="../DocketEntry/AjaxResponse.aspx?mode=check&code1=partytest&code2=" + txt.value + "&code3=" + tp + "&code4=" + loccode + "&sid=" + Math.random() + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        alert("This Party doesn't Exists OR deactivated OR not For Location " + loccode);
                        txt.value="";
                        txtname.value="";
                        txt.focus();
                        hdnajaxstate.value="0";
                        return false;
                     }
                   else if(res[0]=="true")
                   {
                       txtname.value=res[1];
    	               hdnajaxstate.value="0";  // BECAUSE AJAX STEP IS OVER
                   }
                }
         }
         
    findobj.send(null);
    }
    
   return true;
}


function btncustinfoClick()
{

         var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    if(hdnajaxstate.value!="0")
	    {
	        alert("Let the internal process over...Try after 5-10 Seconds...");
	        return false;
	    }

    // Consignor Validations
    var txtcsgncd=document.getElementById("ctl00_MyCPH1_txtcsgncd");
    var txtcsgnname=document.getElementById("ctl00_MyCPH1_txtcsgnname");
    var txtcsgnaddress=document.getElementById("ctl00_MyCPH1_txtcsgnaddress");
    var txtcsgncity=document.getElementById("ctl00_MyCPH1_txtcsgncity");
    var txtcsgnpin=document.getElementById("ctl00_MyCPH1_txtcsgnpin");
    var txtcsgnphone=document.getElementById("ctl00_MyCPH1_txtcsgnphone");
  
    
    if(txtcsgncd.value=="")
    {
        if(txtcsgnname.value=="")
        {
            alert("Please Enter Consignor Name...");
            txtcsgnname.select();
            return false;
        }
        
        if(txtcsgnaddress.value=="")
        {
            alert("Please Enter Consignor Address...");
            txtcsgnaddress.select();
            return false;
        }
        
        if(txtcsgncity.value=="")
        {
            alert("Please Enter Consignor City...");
            txtcsgncity.select();
            return false;
        }
        
        if(txtcsgnpin.value=="")
        {
            alert("Please Enter Consignor PinCode...");
            txtcsgnpin.select();
            return false;  
        }
        
        if(txtcsgnpin.value.length!=6)
        {
            alert("Please Enter valid Consignor Pincode.");
            txtcsgnpin.select();
            txtcsgnpin.focus();
            return false;
        }
        
        if(txtcsgnphone.value=="")
        {
            alert("Please Enter Consignor Phone Number...");
            txtcsgnphone.select();
            return false;
        }
    }


    // Consignee Validations
    var txtcsgecd=document.getElementById("ctl00_MyCPH1_txtcsgecd");
    var txtcsgename=document.getElementById("ctl00_MyCPH1_txtcsgename");
    var txtcsgeaddress=document.getElementById("ctl00_MyCPH1_txtcsgeaddress");
    var txtcsgecity=document.getElementById("ctl00_MyCPH1_txtcsgecity");
    var txtcsgepin=document.getElementById("ctl00_MyCPH1_txtcsgepin");
    var txtcsgephone=document.getElementById("ctl00_MyCPH1_txtcsgephone");
    
    
    if(txtcsgecd.value=="")
    {
        if(txtcsgename.value=="")
        {
            alert("Please Enter Consignee Name...");
            txtcsgename.select();
            return false;
        }
        
        if(txtcsgeaddress.value=="")
        {
            alert("Please Enter Consignee Address...");
            txtcsgeaddress.select();
            return false;
        }
        
        if(txtcsgecity.value=="")
        {
            alert("Please Enter Consignee City...");
            txtcsgecity.select();
            return false;
        }
        
        if(txtcsgepin.value=="")
        {
            alert("Please Enter Consignee PinCode...");
            txtcsgepin.select();
            return false;  
        }
        
        if(txtcsgepin.value.length!=6)
        {
            alert("Please Enter valid Consignee Pincode.");
            txtcsgepin.select();
            txtcsgepin.focus();
            return false;
        }
        
        if(txtcsgephone.value=="")
        {
            alert("Please Enter Consignee Phone Number...");
            txtcsgephone.select();
            return false;
        }
    }
}


/*****************************************************************************************************************
    THIS FUCNTION IS USED TO TEST VALID BRANCH CODE OR LOCATION CODE
*****************************************************************************************************************/
function locTest(txtid,tp)
{
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";

    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
    
    var txt=document.getElementById(txtid);
    if(txt.value=="") 
    {   
        hdnajaxstate.value="0";
        return false;
    }
    
    txt.value=txt.value.toUpperCase();
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        if(tp=="delloc")
            var strpg="../DocketEntry/AjaxResponse.aspx?mode=check&code1=delloc&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
        else
            var strpg="../DocketEntry/AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                  var  res=findobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        if(tp=="delloc")
                            {
                                if(hdnclient.value=="RLL")
                                    {
                                        alert("This Location doesn't Exists or Regional Office or HeadOffice.");
                                    }
                                else
                                    alert("This Location doesn't Exists ");
                             }
                        else
                            alert("This Location doesn't Exists ");
                        txt.value="";
                        txt.focus();
                        hdnajaxstate.value="0";
                        return false;
                     }
                  else if(res[0]=="true")
                  {
                    hdnajaxstate.value="0";
                  }
                     

                }
         }
         
    findobj.send(null);
    }

   return true;
}
    </script>

    <br />
    <br />
    <asp:Panel Width="10in" runat="server" ID="divfields" HorizontalAlign="Center">
        <asp:Table runat="server" CssClass="boxbg" CellSpacing="1" BorderWidth="0" Width="80%">
            <asp:TableRow BackColor="White">
                <asp:TableCell HorizontalAlign="Left">Docket Number</asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                    <asp:Label ID="lbldockno" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White" ID="trtxt">
                <asp:TableCell Width="150px" HorizontalAlign="Left">
                    <asp:Label ID="lbldesc" runat="server" CssClass="blackfnt"></asp:Label>
                </asp:TableCell>
                <asp:TableCell BackColor="White" Width="10px">
                    <asp:Table runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:TextBox ID="txtone" runat="server" Width="100px" onblur="javascript:this.value=this.value.toUpperCase()"
                                    CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txttwo" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <input type="button" id="btnpartypopup" runat="server" class="blackfnt" value="...." />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White" runat="server" ID="trchk">
                <asp:TableCell HorizontalAlign="Left">
                    <asp:Label ID="lblcheckname" runat="server" CssClass="blackfnt"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                    <asp:CheckBox ID="chkone" runat="server" CssClass="blackfnt" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White" runat="server" ID="trcmb">
                <asp:TableCell HorizontalAlign="Left">
                    <asp:Label ID="lbllistname" runat="server" CssClass="blackfnt"></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                    <asp:DropDownList ID="cmblist" runat="server" CssClass="blackfnt" BackColor="White"></asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:Button ID="btnsubmit" runat="server" CssClass="blackfnt" OnClientClick="javascript:return submitClick()"
                        Text="Submit" OnClick="btnsubmit_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:Panel ID="divcustinfo" runat="server" Width="10in">
        <asp:Table ID="tblconsignee" HorizontalAlign="left" runat="server" Style="width: 100%"
            CellSpacing="1" CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                                        Consignor</asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                                        Consignee</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="#ffffff">
                <asp:TableCell>
                                        Code</asp:TableCell>
                <asp:TableCell>
                    <font class="redfnt"><b>*</b></font>Enter From Existing Consignor<br />
                    <asp:TextBox ID="txtcsgncd" runat="server" TabIndex="1" MaxLength="10" onblur="javascript:return partyTest('csgn',this.getAttribute('id'))"
                        Width="60px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>-
                    <asp:TextBox ID="txtcsgnnm" runat="server" Enabled="false" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                    <input type="button" id="btncsgnpopup" value="..." tabindex="2" onclick="javascript:return popupConsignor()"
                        class="blackfnt" runat="server" />
                </asp:TableCell>
                <asp:TableCell>
                    <font class="redfnt"><b>*</b></font>Enter From Existing Consignee<br />
                    <asp:TextBox ID="txtcsgecd" runat="server" TabIndex="2" MaxLength="10" onblur="javascript:return partyTest('csge',this.getAttribute('id'))"
                        Width="60px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>-
                    <asp:TextBox ID="txtcsgenm" runat="server" Enabled="false" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                    <input type="button" id="btncsgepopup" value="..." tabindex="2" onclick="javascript:return popupConsignee()"
                        class="blackfnt" runat="server" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="#ffffff">
                <asp:TableCell ColumnSpan="3" HorizontalAlign="center">
                                        <b>New</b></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="#ffffff">
                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Name</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgnname" runat="server" MaxLength="30" Width="140px" TabIndex="1"
                        BorderStyle="Groove" CssClass="blackfnt" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgename" runat="server" MaxLength="30" Width="140px" TabIndex="2"
                        BorderStyle="Groove" CssClass="blackfnt" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="#ffffff">
                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Address</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgnaddress" TextMode="MultiLine" CssClass="blackfnt" TabIndex="1"
                        BorderStyle="Groove" Width="170px" runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgeaddress" TextMode="MultiLine" CssClass="blackfnt" TabIndex="2"
                        BorderStyle="Groove" Width="170px" runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="#ffffff">
                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>City-Pincode</asp:TableCell>
                <asp:TableCell VerticalAlign="top">
                    <asp:Table runat="server">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="left">
                                <asp:TextBox ID="txtcsgncity" CssClass="blackfnt" TabIndex="1" BorderStyle="Groove"
                                    MaxLength="20" Width="100px" runat="server"></asp:TextBox>
                                <input type="button" id="btncsgncitypopup" onclick="javascript:return popupCSGNCity()"
                                    value="..." class="blackfnt" runat="server" />-
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="txtcsgnpin" runat="server" CssClass="blackfnt" Width="70px" BorderStyle="groove"
                                    MaxLength="6" onkeypress="javascript:return validInt(event)" TabIndex="1" Style="text-align: right;"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
                <asp:TableCell VerticalAlign="top">
                    <asp:Table runat="server">
                        <asp:TableRow>
                            <asp:TableCell HorizontalAlign="left">
                                <asp:TextBox ID="txtcsgecity" CssClass="blackfnt" TabIndex="2" BorderStyle="Groove"
                                    MaxLength="20" Width="100px" runat="server"></asp:TextBox>
                                <input type="button" id="btncsgecitypopup" onclick="javascript:return popupCSGECity()"
                                    value="..." class="blackfnt" runat="server" />-
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                                <asp:TextBox ID="txtcsgepin" runat="server" CssClass="blackfnt" Width="70px" MaxLength="6"
                                    onkeypress="javascript:return validInt(event)" BorderStyle="groove" TabIndex="2"
                                    Style="text-align: right;"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="#ffffff">
                <asp:TableCell>
                        <font class="redfnt"><b>*</b></font>Telephone</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgnphone" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                        Style="text-align: right;" TabIndex="1" onkeypress="javascript:return validInt(event)"
                        Width="100px" runat="server"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgephone" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                        Style="text-align: right;" TabIndex="2" onkeypress="javascript:return validInt(event)"
                        Width="100px" runat="server"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="#ffffff">
                <asp:TableCell>
                                        E-mail</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgnemail" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                        TabIndex="1" Width="100px" runat="server" onblur="javascript:return emailCheck(this.getAttribute('id'))"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtcsgeemail" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                        TabIndex="2" Width="100px" runat="server" onblur="javascript:return emailCheck(this.getAttribute('id'))"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="3">
                    <asp:Button ID="btncustinfo" runat="server" CssClass="blackfnt" OnClientClick="javascript:return btncustinfoClick()"
                        Text="Submit" OnClick="btncustinfo_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
    </asp:Panel>
    <asp:HiddenField ID="hdnajaxstate" Value="0" runat="server" />
    <asp:HiddenField ID="hdnrequestcode" runat="server" />
    <asp:HiddenField ID="hdnpaybas" runat="server" />
    <asp:HiddenField ID="hdnorgnloc" runat="server" />
    <asp:HiddenField ID="hdndelloc" runat="server" />
    <asp:HiddenField ID="hdndockno" runat="server" />
    <asp:HiddenField ID="hdnfinyear2d" runat="server" />
</asp:Content>
