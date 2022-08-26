<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Direct_Agent_Voucher.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                        <b>&gt; </b></a><a><font class="bluefnt"><b>Prepare Direct Octroi Payment </b></font>
                        </a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
    var form_name="ctl00$MyCPH1$"
    
function cahs_N_bank(obj)
    { 
    }
    
    Form_name="ctl00$MyCPH1$"
      function ValidateData()
   {
                

     
                                        
        if(document.getElementById(Form_name+"cboModeOfTransaction").value=="")
        {
            alert("Select Mode Of Payment");
            return false;
        }
        if(document.getElementById(Form_name+"cboModeOfTransaction").value=="Cheque")
        {
          if(document.getElementById(Form_name+"txtchno").value=="")
          {
             alert("Enter Cheque No.");
            return false;
          }
           if(document.getElementById(Form_name+"txtchdt").value=="")
          {
             alert("Enter Cheque Date.");
            return false;
          }
                
        }
                                        
                                          
        var mDerviedControlForDocketNo = "";
        var mDerviedControlForMRReceiptNo = "";
        var mDerviedControlForMRReceiptDate = "";
       
        var myflg="n";
        
        //Check for No. of Rows
        if(document.getElementById("ctl00_MyCPH1_roww"))
        {
            if(document.getElementById("ctl00_MyCPH1_roww").value != "")
            {
                for(var mLoopCounter = 1; mLoopCounter <= document.getElementById("ctl00_MyCPH1_roww").value; mLoopCounter++)
                {
                    
                    j=mLoopCounter+1
                    mDerviedControlForDocketNo = "ctl00_MyCPH1_GV_D_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtdockno";
                    mDerviedControlForMRReceiptNo = "ctl00_MyCPH1_GV_D_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcpno";
                    mDerviedControlForMRReceiptDate = "ctl00_MyCPH1_GV_D_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcpdt"
                    
                         if(mLoopCounter < 10)
                        {
                                               
                            frm3=Form_name+"GV_D$ctl"+"0"+j+"$"
                        }
                        else
                        {
                            frm3=Form_name+"GV_D$ctl"+j+"$"
                           
                        }
                    
                        
                        
                    if(document.getElementById(mDerviedControlForDocketNo) && document.getElementById(mDerviedControlForMRReceiptNo) && document.getElementById(mDerviedControlForMRReceiptDate))
                    {
                        if(document.getElementById(mDerviedControlForDocketNo).value != "")
                        {      
                        myflg="y";                     
                            if(document.getElementById(mDerviedControlForMRReceiptNo).value == "")
                            {
                                alert("Enter Receipt No. for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptNo).focus();
                                return false;
                            }
                            if(document.getElementById(mDerviedControlForMRReceiptDate).value == "")
                            {
                                alert("Enter Receipt Date for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptDate).focus();
                                return false;
                            }
                        }
                    }                    
                }
            }
            else
            {
                return false;
            }
        }
        
        if(myflg=="n")
        {
            alert("Enter Atleast One Docket No.")
            return false;
        }
        
        return true;
        
        
   }

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

function validint(event,txtid)
{
 
var tb=document.getElementById(txtid);
var txt=tb.value;
if(event.keyCode==13)
return true;

if(event.keyCode==46)
event.keyCode=0;
 

if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
{event.keyCode=0;return false;}
}


function nonenone(event,txtid)
{
 
var tb=document.getElementById(txtid);
var txt=tb.value;
if(event.keyCode==13)
return true;
 
event.keyCode=0;return false;
//}
}

    function validRPDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Recipt Date"))
        txtdate.focus();
            return false;
}
    function validRP1Date(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Checque Date"))
        txtdate.focus();
            return false;
}
    
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
	
	
	var p=true
	function doWork() {
	   
	    if (doc.readyState == 4) {
	    
	     
	    
	    
	     //alert(doc.responseText)
	          
	           
	           var res=doc.responseText.split("|");
	           
	           if (res[0]!="OK")
	           {
	          
	            alert(doc.responseText)
	            p=false
	            rt="";
	           // formobj.focus();
	           var s2= document.getElementById("ctl00_MyCPH1_h2").value;
	                  document.getElementById(s2).value = "";
	            return false;
	                //formobj.value="";
	              
	           }
	           else
	           {
	         //  debugger
	                  var s= document.getElementById("ctl00_MyCPH1_hi").value;
	                  document.getElementById(s).value = res[1];
	           }
	    }
	}
       
        var f1,f2
        f1="1"
        f2="1"
        var dno=""


function dktcheck(d)
        {
   var txdec=d.id;
         
          txdec=txdec.replace( "txtdockno", "txtoctamt");
          
          document.getElementById("ctl00_MyCPH1_h2").value=d.id;
            document.getElementById("ctl00_MyCPH1_hi").value=txdec;
        var dno=d.value;
          
                createXMLHTTPObject();
                 if (doc)
				 { 
             	                arg=new Date()
					            doc.onreadystatechange = doWork; 
					            if(dno=="")
					            {
					             alert("Enter Docket No.")
					           
//					             d.focus();
 //				               return false;
					            }
					            else
					            {
					                doc.open("GET", "directchk.aspx?dno=" + dno, false);
					                doc.send(null);
					            }
				  }
               
             
        }
/*
function checklocation(obj)
        {
        
        var a;
        a=1;
     obj.value = obj.value.toUpperCase()
        //str=str.toUpperCase()
        
        if(obj.value != "")
        {
       for(i=0;i<str.length;i++)
       {
       
       str[i]=str[i].toUpperCase()

            if(obj.value==str[i])
            {
                 a=2
                  break;
               
                
            }
            else
            { 
               
                continue
            }
       }
      
       if(a!=2)
       {
             alert("Invalid Cnote/HWB No.")
           obj.focus();
       }
       }
 

}   */

 

function check2(octamt,t_otheramt,txtnetpay)
{

var varoctamt = octamt.value
var t_otheramt = t_otheramt.value 
 var tdsrate=document.getElementById(form_name+"tdsrate").value
var Tdsamt=document.getElementById(form_name+"Tdsamt").value
if(parseFloat(tdsrate)>0)
{
document.getElementById(form_name+"Tdsamt").value =Math.round(parseFloat(t_otheramt)*parseFloat(tdsrate) /100 )
}

var tott=Number(varoctamt)+Number(t_otheramt)-Number(document.getElementById(form_name+"Tdsamt").value)

txtnetpay.value = tott
//txtchamt
document.getElementById("ctl00$MyCPH1$txtchamt").value=tott


}



function check(octamt,t_otheramt,txtnetpay)
{


var varoctamt = octamt.value
var t_otheramt = t_otheramt.value 
var varnetpay = txtnetpay.value 
  
var totalrow=document.getElementById("ctl00$MyCPH1$roww").value
    var Formnae="ctl00$MyCPH1$GV_D$ctl"//02$txtoctamt"
                
    var total_octamt=0
    var octamount=0
    for (i=0;i<totalrow;i++ )
    {

        j=i+2;
        
        if(j<10)
        {
            GV_frmname=Formnae+"0"+j+"$"
           
        }
        else
        {
        GV_frmname=Formnae+j+"$"
        
        }
        octamount=document.getElementById(GV_frmname+"txtoctamt").value
        if(octamount=="")
        {
        octamount=0
        }
      if (document.getElementById(GV_frmname+"txtdockno").value!="")
      {  
      total_octamt=parseFloat(total_octamt)+parseFloat(octamount)
      }
       
    }
    k=j+1
    if(k<10)
        {
            GV_frmname1=Formnae+"0"+k+"$"
           
        }
        else
        {
        GV_frmname1=Formnae+k+"$"
        }
        
document.getElementById(GV_frmname1+"txttot").value=total_octamt
document.getElementById("ctl00$MyCPH1$h_tot").value=total_octamt


//+parseFloat(t_otheramt) 
octamt.value=total_octamt//+parseFloat(t_otheramt) 
txtnetpay.value =total_octamt+parseFloat(t_otheramt) 

//var vartotdue = Number(total_octamt)+Number(t_otheramt.value)
//alert(txtnetpay.value)
document.getElementById("ctl00$MyCPH1$txtchamt").value = total_octamt+parseFloat(t_otheramt) -Number(document.getElementById(form_name+"Tdsamt").value)
//Number(vartotdue)

}
function Nagative_Chk(obj)
{
var temp
temp=obj.value
//alert(temp)
if (temp=="")
{
alert("Value can not be blank")
obj.focus();
return false;
}
if(isNaN(temp))
{
alert("Value should be Numeric")
obj.value=""
obj.focus();
return false;
}
if(parseFloat(temp)<0)
{
alert("Value should be greater than zero")
obj.value=""
obj.focus();
return false;
}
 
return true;
}
function Nagative_Chk_wDecimal(obj)
{
var temp
temp=obj.value
//alert(temp)
if (temp=="")
{
alert("Value can not be blank")
obj.focus();
return false;
}
if(isNaN(temp))
{
alert("Value should be Numeric")
obj.value=""
obj.focus();
return false;
}
if(parseFloat(temp)<0)
{
alert("Value should be greater than zero")
obj.value=""
obj.focus();
return false;
}
obj.value=roundit(temp)
return true;
}

 

function roundit(Num)
{
Places=2
if (Places > 0)
{
if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1))
{
if (Num.toString().lastIndexOf('.') < 0)
{
return Num.toString() +'.00';
}
var Rounder = Math.pow(10, Places);
return Math.round(Num * Rounder) / Rounder;
}
else
{
if (Num.toString().lastIndexOf('.') < 0)
{
return Num.toString() +'.00';
}
else
{
if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
return Num.toString() +'0';
else
return Num.toString();

}
}
}
else return Math.round(Num);
}


    </script>

    <div style="width: 9.5in">
        <br />
        <br />
        <asp:Panel ID="plnerr" Visible="false" runat="server">
            <table width="90%">
                <tr>
                    <td align="center">
                        <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="Label4" Text="Please Try Again....." runat="server"></asp:Label>
                        <br />
                        <br />
                        <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:Panel ID="pnl1" runat="server">
            <br />
            <br />
            <asp:UpdatePanel ID="DataGrid2_Update" runat="server"     UpdateMode="Always" RenderMode="Inline">
                <ContentTemplate>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%"
                        align="center">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                     Octroi Payment Voucher Summary
                                </asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 111px">
                                <font class="blackfnt">Payment Voucher Number</font>
                            </td>
                            <td style="width: 195px">
                                <font class="blackfnt" color="red">System Generated...</font></td>
                            <td style="width: 188px">
                                <font class="blackfnt">Voucher Date</font></td>
                            <td>
                                <asp:TextBox ID="txtbgndt"  runat="server" Width="94px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                    ControlToValidate="txtbgndt"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td>
                                <font class="blackfnt">Octroi Agent </font>
                            </td>
                            <td>
                                <%-- <asp:UpdatePanel ID="up3" runat="server">
                            <ContentTemplate>
                                <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                &nbsp;<asp:DropDownList ID="ddlagnt" runat="server">
                                </asp:DropDownList>
                                <%--  </ContentTemplate>
                        </asp:UpdatePanel>--%>
                            </td>
                            <td>
                                <font class="blackfnt">Paid To </font>
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server" Width="91px"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td>
                                <font class="blackfnt">Octroi paid Rs.</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:TextBox ID="octamt" runat="server" Enabled="false" Width="91px"></asp:TextBox></font></td>
                            <td>
                                <font class="blackfnt">Other Charges</font></td>
                            <td>
                                <asp:TextBox ID="t_otheramt" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    runat="server" Width="91px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td>
                                <font class="blackfnt">TDS Rate(%)</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:TextBox ID="tdsrate" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                        runat="server" Enabled="false" Width="91px"></asp:TextBox></font></td>
                            <td>
                                <font class="blackfnt">TDS Amt.</font></td>
                            <td>
                                <asp:TextBox ID="Tdsamt" Enabled="false" Text="0.00" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    runat="server" Width="91px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td>
                                <font class="blackfnt">TDS Type</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:DropDownList ID="cboTDSType" CssClass="blackfnt" runat="server" Mode="Conditional"
                                        RenderMode="Inline" Width="152px">
                                    </asp:DropDownList>
                                </font>
                            </td>
                            <td>
                                <font class="blackfnt">TDS Deducted For</font></td>
                            <td>
                                <asp:DropDownList ID="cboTDSDeducted" CssClass="blackfnt" runat="server" Mode="Conditional"
                                    RenderMode="Inline" Width="152px">
                                    <%-- <asp:ListItem Text="Select" Value=""></asp:ListItem>--%>
                                    <asp:ListItem Text="Corporate" Value="C" Selected="true"></asp:ListItem>
                                    <asp:ListItem Text="NonCorporate" Value="NC"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td>
                                <font class="blackfnt">Net Payable </font>
                                <asp:HiddenField ID="h_tot" runat="server" />
                            </td>
                            <td>
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtnetpay" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                        runat="server" Width="91px"></asp:TextBox></font></td>
                            <td>
                                <font class="blackfnt"></font>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                    &nbsp;<br />
                    <center>
                        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" align="center">
                            <tr bgcolor="white">
                                <td align="left" style="width: 91px; height: 40px;">
                                    <font class="bluefnt">Enter Row No *</font></td>
                                <td style="height: 40px">
                                    <asp:TextBox ID="roww" runat="server" Width="40px" BorderStyle="Groove" AutoPostBack="True"
                                        onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" OnTextChanged="roww_TextChanged"></asp:TextBox></td>
                            </tr>
                        </table>
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></center>
                    <center>
                        &nbsp;</center>
                    <center>
                        <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                            Width="80%" PagerStyle-HorizontalAlign="left" ShowFooter="True" CssClass="boxbg"
                            CellSpacing="1" CellPadding="5" BorderWidth="0" FooterStyle-CssClass="boxbg"
                            AutoGenerateColumns="False" SelectedIndex="1">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Docket Number  ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="100px" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" CssClass="blackfnt" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtdockno" runat="server" onblur="return dktcheck(this)"></asp:TextBox>
                                        <%--<asp:TextBox ID="txtddd" runat="server"   Visible="false" ></asp:TextBox>--%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblttt" CssClass="blackfnt" runat="server">Total : </asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Octroi Amount  ">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtoctamt" Width="120" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                        <%--OnTextChanged="OnAmtChg" AutoPostBack="true" --%>
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtoctamt"></asp:RequiredFieldValidator>--%>
                                        <%-- <asp:RegularExpressionValidator id="reg1" runat="server" ValidationExpression="0-9" ControlToValidate="txtoctamt"></asp:RegularExpressionValidator>--%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txttot" Width="120" runat="server" BorderStyle="Groove" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                            Columns="8"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Octroi receipt no.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtrcpno" Width="120" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtrcpno"></asp:RequiredFieldValidator>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Receipt date (DD/MM/YYYY)">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtrcpdt" Width="120" runat="server" onblur="javascript:return validRPDate(this.getAttribute('id'));"
                                            BorderStyle="Groove" Columns="8"></asp:TextBox>
                                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtrcpdt"></asp:RequiredFieldValidator>--%>
                                        <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtrcpdt"
                                        Width="50" ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
                        </asp:GridView>
                        &nbsp;</center>
                    <center>
                        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Remark"></asp:Label>
                        <asp:TextBox ID="txtremarks" runat="server" Height="49px" TextMode="MultiLine" Width="381px"></asp:TextBox>
                    </center>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
                </Triggers>
            </asp:UpdatePanel>
            <br />
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%"
                align="center">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="True">Payment summary </asp:Label>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Mode Of Transaction </font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:UpdatePanel ID="u1" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cboModeOfTransaction" runat="server" Width="60px" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged"
                                        AutoPostBack="true">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                                        <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
                                        <asp:ListItem Text="DD" Value="DD"></asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Payment Account</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cboPaymentAccount" runat="server" Width="152px" AutoPostBack="true"
                                        onchange="javascript:cahs_N_bank(this)">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cboModeOfTransaction" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="white" style="height: 25px; color: #000000;">
                    <td>
                        <font class="blackfnt">Cheque No </font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtchno" onkeypress="javascript:return validint(event,this.getAttribute('id'));"
                            MaxLength="6" runat="server" Width="91px"></asp:TextBox>
                        <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidatorr" runat="server" ErrorMessage="*"
                        ControlToValidate="txtchno"></asp:RequiredFieldValidator>--%>
                    </td>
                    <td>
                        <font class="blackfnt">Cheque Date </font>
                        <asp:HiddenField ID="hi" runat="server" />
                        <asp:HiddenField ID="h2" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtchdt" runat="server" onblur="javascript:return validRP1Date(this.getAttribute('id'));"
                            Width="91px"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatordt" runat="server" ErrorMessage="*"
                            ControlToValidate="txtchdt"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator31" runat="server"
                            ControlToValidate="txtchdt" ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator>
                    --%>
                    </td>
                </tr>
                <tr bgcolor="white" style="height: 15px">
                    <td>
                        <font class="blackfnt">Payment Amount</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:TextBox ID="txtchamt" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                runat="server" Width="91px"></asp:TextBox></font></td>
                    <td>
                        <font class="blackfnt"></font>
                    </td>
                    <td>
                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidatorr2" runat="server" ErrorMessage="*"
                            ControlToValidate="txtchamt"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtnetpay"
                            ControlToValidate="txtchamt" ErrorMessage="Must Equal To Net Amout"></asp:CompareValidator>--%>
                    </td>
                </tr>
            </table>
            <br />
            <center>
                <asp:Button ID="Button11" runat="server" OnClientClick="return ValidateData()" Text="Submit"
                    OnClick="Button11_Click" /></center>
        </asp:Panel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
