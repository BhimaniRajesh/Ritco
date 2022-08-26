<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" CodeFile="Purchase_Order.aspx.cs" Inherits="GUI_Finance_Fix_Asset_aaaaa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    
	    function nwOpen()
        {
            window.open("popupven.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
     
	    function nwOpen2(m1,m2)
        {
        //debugger
            window.open("popupasset.aspx?cd=" + m1+"&nm="+m2,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        //ctl00$MyCPH1$txtven
        
        
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
             alert("Vendor Does Not Exist....")
           obj.focus();
       }
       }
 

}  
        
        
function checkfinal()
{

    var totalrow=7
//document.getElementById("ctl00$MyCPH1$roww").value
//alert(totalrow)
    var Formnae="ctl00_MyCPH1_GV_D_ctl"//02$txtoctamt"
    var total_octamt=0
    var octamount=0
    var GV_frmname="ctl00_MyCPH1_GV_D_";
    var GV=document.getElementById("ctl00_MyCPH1_GV_D");
    
   var grandtot=0.00;
   var qtot=0.00;
   
        var r=GV.rows.length;

        var pref="";
        
        var c="N";
        
        for(var i=2;i<r;i++)
        {
            if(i<10)
                pref=GV_frmname + "ctl0" + i + "_";
            else
                pref=GV_frmname + "ctl" + i + "_";
                
                 var ch=document.getElementById(pref + "chksrno");
                 var cd=document.getElementById(pref + "txtassetcd");
                 var nm=document.getElementById(pref + "txtastnm");
         if(ch.checked == true)
         {
            c="Y";
         if(cd.value=="")
            {
             alert("Please Enter Asset Code....")
             cd.focus();
            return false;
            
            }
             if(nm.value=="")
            {
            alert("Please Enter Asset Name....")
            nm.focus();
            return false;
            
            }
            
         var txtrate=document.getElementById(pref + "txtrate");
         var txtper=document.getElementById(pref + "txtperct");
         var txtqty=document.getElementById(pref + "txtqty");
         var txttot=document.getElementById(pref + "txttot");
         
         
         var t =(((Number(txtper.value)* Number(txtrate.value))/100)*Number(txtqty.value)) + (Number(txtrate.value) * Number(txtqty.value))    
            txttot.value=t;         

            grandtot=grandtot + t;
            qtot+=Number(txtqty.value);
        
         
          //  alert(grandtot);
        }
        
        
       document.getElementById("ctl00$MyCPH1$hh1").value=qtot;
       document.getElementById("ctl00$MyCPH1$GV_D$ctl12$txttottot").value=grandtot;
        }
        if(c == "N")
        {
            alert("Please Select Atleast One....")
            return false;
        }
        

} // checkfind ENDS HERE

function cahs_N_bank(obj)
    {
        frm_name="ctl00$MyCPH1$"

        if(obj.value=="Cash")
        {
            document.getElementById(frm_name+"txtCashAmount").value="<%=PaymentAmt%>"
            document.getElementById(frm_name+"txtPaymentAmt").value="0.00"
        }
        else
        {
            document.getElementById(frm_name+"txtPaymentAmt").value="<%=PaymentAmt%>"
            document.getElementById(frm_name+"txtCashAmount").value="0.00"
            }
    }

function bal()
{
      var tot1= document.getElementById("ctl00$MyCPH1$GV_D$ctl12$txttottot")
      var adv= document.getElementById("ctl00$MyCPH1$txtadv")
      if(Number(tot1.value)<Number(adv.value))
      {
        alert("Advance Amount can not be Greater than Total Amount");
        adv.focus();
        return false;
      }
      else
      {
          var balamt=Number(tot1.value)-Number(adv.value)
          
          if(document.getElementById("ctl00$MyCPH1$cboModeOfTransaction").value=="Cash")
          {
             document.getElementById("ctl00$MyCPH1$txtCashAmount").value=adv.value;
          }
          else
          {
                       document.getElementById("ctl00$MyCPH1$txtCashAmount").value=adv.value;
             document.getElementById("ctl00$MyCPH1$txtPaymentAmt").value=adv.value;
          }
          document.getElementById("ctl00$MyCPH1$txtbalamt").value=balamt;
 }
      
}


function validPODate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Purchase Order"))
            return false;
}



function validQuotationDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Quotation"))
            return false;
}


function validRequisitionDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Requisition"))
            return false;
}


function validChequeDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Cheque"))
            return false;
}

function validateBoxes()
{

 if(checkfinal()== false)
 {
            return false;
            }
            else
            {
          //   alert("hiii...........");

    var txtpodate=document.getElementById("ctl00_MyCPH1_txtpodt");
    var txtqdt=document.getElementById("ctl00_MyCPH1_txtqdt");
    var txtreqdt=document.getElementById("ctl00_MyCPH1_txtreqdt");
    var txtchequedate=document.getElementById("ctl00_MyCPH1_txtreqdt")
    var mode=document.getElementById("ctl00_MyCPH1_cboModeOfTransaction")
    var bnk=document.getElementById("ctl00_MyCPH1_cboPaymentAccount")
    
 //   alert(mode.value);
    if(mode.value=="")
    {
        alert("Please Select Mode Of Payment");
        mode.focus();
        return false;
    }
   // alert(bnk.value);
    if(bnk.value=="")
    {
        alert("Please Select PaymentAccount");
        bnk.focus();
        return false;
    }
    
      if(!isValidDate(txtpodate.value,"Purchase Order"))
            return false;
            
      if(!isValidDate(txtqdt.value,"Quotation"))
            return false;
    
      if(!isValidDate(txtreqdt.value,"Requisition"))
            return false;
            
        if(!isValidDate(txtchequedate.value,"Cheque"))
            return false;      
    
    
    var GV_frmname="ctl00_MyCPH1_GV_D_";
    var GV=document.getElementById("ctl00_MyCPH1_GV_D");
    
    
      var r=GV.rows.length;

        var pref="";
        for(var i=2;i<r;i++)
        {
            if(i<10)
                pref=GV_frmname + "ctl0" + i + "_";
            else
                pref=GV_frmname + "ctl" + i + "_";
        
        
            var txttot=document.getElementById(pref + "txttot");
            txttot.disabled=false;
        
        }
        
       document.getElementById("ctl00$MyCPH1$GV_D$ctl12$txttottot").disabled=false;
       }
       return true;
       
    
}


// this function assignment in keypress doesn't allow any character other than number.
function validInt(event)
{
if(event.keyCode==13)
{
return true;
}
if(event.keyCode<48 || event.keyCode>57)
{
event.keyCode=0;return false;
}
}

// this function assignment in keypress doesn't allow any character other than number and a dot.
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



    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font></a> <b>&gt; </b><a><font class="blklnkund"><b>Fix Asset Management</b></font></a>
                <b>&gt; </b><font class="bluefnt"><b>Add a Purchase Order </b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:Panel ID="plnerr" Visible="false" runat="server">
        <table width="90%">
            <tr>
                <td align="center">
                    <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                    <br />
                    <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label><br />
                    <br />
                    <br />
                    <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnl1" runat="server">
        <div style="width: 10in">
            <table align="center" cellspacing="1" style="width: 80%" cellpadding="5" border="0"
                class="boxbg" border="0">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       General Information
                        </asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td>
                        <label class="blackfnt">
                            P.O. ID :
                        </label>
                    </td>
                    <td>
                        <asp:Label ID="l1" Text="< System Generated... >" runat="server" ForeColor="red" 
                            CssClass="blackfnt"></asp:Label></td>
                    <td>
                        <label class="blackfnt">
                            P.O. Date :</label></td>
                    <td>
                        <asp:TextBox ID="txtpodt" Width="100" runat="server" onblur="javascript:return validPODate(this.getAttribute('id'));"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtpodt,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="a2">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a><font class="blackfnt">dd/mm/yyyy</font>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td>
                        <label class="blackfnt">
                            Vendor Code :</label><asp:HiddenField ID="hh1" runat="server" />
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtven" onblur="return checklocation(this)" Width="100" runat="server"></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" TabIndex="18" Text='<a href="javascript:nwOpen()">...</a>' BorderStyle="groove"
                            Width="14px"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td style="height: 26px">
                        <label class="blackfnt">
                            Quotation No.:
                        </label>
                    </td>
                    <td style="height: 26px">
                        <asp:TextBox ID="txtqno" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td style="height: 26px">
                        <label class="blackfnt">
                            Quotation Date:
                        </label>
                    </td>
                    <td style="height: 26px">
                        <asp:TextBox ID="txtqdt" Width="100" runat="server" onblur="javascript:return validQuotationDate(this.getAttribute('id'))"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtqdt,'anchor3','dd/MM/yyyy'); return false;"
                            name="anchor3" id="a3">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a><font class="blackfnt">dd/mm/yyyy</font>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td>
                        <label class="blackfnt">
                            Kind Attn. :</label></td>
                    <td colspan="3">
                        <asp:TextBox ID="txtkind" Width="130" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">
                                      Enter the Assets Details
                        </asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:UpdatePanel ID="u2" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                                    FooterStyle-CssClass="balckfnt" PagerStyle-HorizontalAlign="left" ShowFooter="True"
                                    FooterStyle-BackColor="white" CellPadding="5" CellSpacing="1" BorderWidth="0"
                                    CssClass="boxbg" OnRowDataBound="GV_D_OnRowDataBound" AutoGenerateColumns="False"
                                    SelectedIndex="1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO.">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" Width="50" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                </asp:Label>
                                                <asp:CheckBox ID="chksrno" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Asset Code " HeaderStyle-Width="150">
                                            <HeaderStyle HorizontalAlign="Center" Width="100" Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtassetcd" Width="60" runat="server"></asp:TextBox><asp:Button
                                                    ID="btncodepopup" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Asset Name ">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" BackColor="white" Width="150" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtastnm" Width="170" MaxLength="25" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtdesc" Width="150" TextMode="MultiLine" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Qty.">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" Width="80" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtqty" Width="70" MaxLength="4" onkeypress="javascript:return validInt(event)"
                                                    runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="% Of Tax ">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtperct" Width="70" MaxLength="4" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                    runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rate ">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtrate" Width="70" MaxLength="4" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                    onblur="javascript:return checkfinal()" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lll" Text="Total :" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Amount ">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                            <ItemStyle BackColor="white" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txttot" MaxLength="4" runat="server" Enabled="false"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox ID="txttottot" runat="server" Enabled="false"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="Right" colspan="3">
                        <asp:Label ID="llll" Text="Advance Amount :" CssClass="blackfnt" Font-Bold="true"
                            runat="server"></asp:Label>
                    </td>
                    <td align="Right" style="height: 21px">
                        <asp:TextBox ID="txtadv" Width="70" onblur="javascript:bal()" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                            MaxLength="7" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td colspan="3" style="width: 90%" align="Right">
                        <asp:Label ID="Label3" Text="Balance Amt. : " CssClass="blackfnt" Font-Bold="true"
                            runat="server"></asp:Label>
                    </td>
                    <td align="Right" style="height: 21px">
                        <asp:TextBox ID="txtbalamt" Width="70" MaxLength="4" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="Right" colspan="3">
                        <asp:Label ID="Label41" Text="Type Of Tax :" CssClass="blackfnt" Font-Bold="true"
                            runat="server"></asp:Label>
                    </td>
                    <td align="Right" style="height: 21px">
                        <asp:TextBox ID="txttaxtype" Width="170" MaxLength="10" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td style="height: 24px">
                        <label class="blackfnt">
                            Requisition No. :
                        </label>
                    </td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtreqno" Width="100" runat="server"></asp:TextBox>
                    </td>
                    <td style="height: 24px">
                        <label class="blackfnt">
                            Requisition Date :</label></td>
                    <td style="height: 24px">
                        <asp:TextBox ID="txtreqdt" Width="100" runat="server"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtreqdt,'anchor5','dd/MM/yyyy'); return false;"
                            name="anchor5" id="a5">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td>
                        <label class="blackfnt">
                            Term & condition :
                        </label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtterm" TextMode="multiLine" Width="300" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td colspan="4" align="center" style="height: 21px">
                        <table border="0" cellspacing="1" cellpadding="4" width="100%" align="left" class="boxbg">
                            <font class="blackfnt">Note : Please enter the payment details if Net Payable amount
                                >0 . </font>
                            <br />
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <font class="blackfnt"><b>Payment Details</font>
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
                            <tr bgcolor="#FFFFFF">
                                <td align="left">
                                    <font class="blackfnt">Cheque No </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtChequeNo" runat="server" Width="70px" MaxLength="6"></asp:TextBox></font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Cheque Date </font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtChequeDate" runat="server" Width="70px" onblur="javascript:ValidateForm(this)"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtChequeDate,'anchor4','dd/MM/yyyy'); return false;"
                                            name="anchor4" id="a4">
                                            <img src="./../../images/calendar.jpg" border="0"></img>
                                        </a>dd/mm/yyyy </font>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td align="left">
                                    <font class="blackfnt">Payment Amount</font></td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtPaymentAmt" runat="server" Enabled="false" Width="70px"></asp:TextBox></font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Cash Amount</font></td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtCashAmount" runat="server" Width="70px" Enabled="false"></asp:TextBox></font>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td align="left" colspan="2">
                                    <font class="blackfnt">Narration</font></td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtNarration" runat="server" Height="56px" Width="200px" TextMode="MultiLine"></asp:TextBox></font>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:Button ID="btn_submit" Width="120" Text="Submit" OnClick="btn_submit_Click"
                            OnClientClick="javascript:return validateBoxes()" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
