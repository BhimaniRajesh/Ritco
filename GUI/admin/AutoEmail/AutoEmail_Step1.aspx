<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="AutoEmail_Step1.aspx.cs" Inherits="GUI_admin_AutoEmail_AutoEmail_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
     function emailCheck(obj) {

var txt=obj;
//alert(obj)
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


function OnSub_DATACHECK()
     {
     
     var txtemailid=document.getElementById("ctl00_MyCPH1_txtemailid");
     var txtName=document.getElementById("ctl00_MyCPH1_txtName");
     var txtUsername=document.getElementById("ctl00_MyCPH1_txtUsername");
     var txtPWD=document.getElementById("ctl00_MyCPH1_txtPWD");
     var txtServer=document.getElementById("ctl00_MyCPH1_txtServer");
     
     if(txtemailid.value=="")
	        {
	         alert("Please Enter  E-Mail Id !!!")
	         txtemailid.focus();
	         return false;
	        }
	        if(txtName.value=="")
	        {
	         alert("Please Enter Display Name !!!")
	         txtName.focus();
	         return false;
	        }
	        if(txtUsername.value=="")
	        {
	         alert("Please Enter  UserName !!!")
	         txtUsername.focus();
	         return false;
	        }
	        if(txtPWD.value=="")
	        {
	         alert("Please Enter  Password !!!")
	         txtPWD.focus();
	         return false;
	        }
	        if(txtServer.value=="")
	        {
	         alert("Please Enter  SMTP Server !!!")
	         txtServer.focus();
	         return false;
	        }
     
     }
     
    </script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Auto E-mail  Create Pofile Step -1 </asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <asp:Table ID="Table1" runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 500px">
        <tr>
            <td align="left" width="15%">
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350">
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Enter Email-Id
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:TextBox ID="txtemailid" runat="server" Width="200" CssClass="input" MaxLength="900" onblur="javascript:return emailCheck(this)" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Enter Display Name
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:TextBox ID="txtName" runat="server" CssClass="input" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Enter UseName
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:TextBox ID="txtUsername" runat="server" Width="200" CssClass="input" MaxLength="900" onblur="javascript:return emailCheck(this)" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Password
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:TextBox ID="txtPWD" TextMode="Password" runat="server" CssClass="input" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Enter Mail Server
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        <asp:TextBox ID="txtServer" runat="server" CssClass="input" ></asp:TextBox>
                        </td>
                    </tr>
                      <tr style="background-color: White">
                        <td colspan="2" style="text-align:  center" class="blackfnt">
                           <asp:Button  ID="btnSubmit" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnSubmit_Click" runat="server" CssClass="blackfnt" Text="Submit" />
                        </td>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
