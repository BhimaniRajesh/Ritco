<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Purchase_Order_old.aspx.cs" Trace="true" Inherits="GUI_Finance_Fix_Asset_Fix_Asset_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">
   
   
   
   
   
   
//   
// function check2(q,p,rt,t)
// {
//        
// //debugger

//        var qt = q.value
//        alert(rt.value);
//        varper1 = Number(p.value) 
//        varrt1 =Number(rt.value)
//         
//        
//       
//        var varpercentage =(((Number(p.value)* Number(rt.value))/100)*Number(q.value)) + (Number(rt.value) * Number(q.value))
//        
//       // percentage = parseFloat(percentage)/100
//        
//        //percentage= percentage * Number(q.value)
//        
//        // 100*Number(txtagnttax.value)/Number(octamt.value)

////        var tott = per * rt
////        tott = tott /100
////        tott = tott * qt
//        
//        t.value = varpercentage



//    }
 

//function ch()
//{
// debugger
//  var grid=document.getElementById("ctl00_MyCPH1_GV_D");
//  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_D"
//  var arrstr="";
//  for(var b=4;b<rows;b++)
//  {
//        var c="";
//        var rt="";
//        var qt="";
//        var t1="";
//        var t2="";
//        var per="";
//         
//        
//        if(b<10)
//        {
//            c="ctl00_MyCPH1_GV_D_ctl0" + b + "_chksrno";
//            
//            rt="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtrate";
//            qt="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtqty";
//            t1="ctl00_MyCPH1_GV_D_ctl0" + b + "_txttot";
//            t2="ctl00_MyCPH1_GV_D_ctl0" + b + "_txttottot";
//            per="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtperct";
//            
//            
//        }
//        else
//        {
//            c="ctl00_MyCPH1_GV_D_ctl" + b + "_chksrno";
//            
//            rt="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtrate";
//            qt="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtqty";
//            t1="ctl00_MyCPH1_GV_D_ctl0" + b + "_txttot";
//            t2="ctl00_MyCPH1_GV_D_ctl0" + b + "_txttottot";
//            per="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtperct";
//            
//        }
//        
//        var varpercentage =(((Number(per.value)* Number(rt.value))/100)*Number(qt.value)) + (Number(rt.value) * Number(qt.value))
//        
////         t2.value="Sandy";
////         t1.value="Sandy";
//         //varpercentage;
//     
//        var tb1=document.getElementById(c);

//        var q ="n"
//        
//        if(tb1.checked == true)
//        {
//            q="y"
//            return true;
//        }
//        else
//        {
//             continue
//        }
//        
//    
// }
// 
//          t2.value="Sandy";
//         t1.value="Sandy";
//  ctl00$MyCPH1$GV_D$ctl12$txttottot
//    if(q == "n")
//    {
//        alert("Please Select Atleast One....")
//        return false;
//    }
//    
//    
//    
//    
    
//}
    
    
    
    
    
    




//function check(per,qty,rt,t1)
//{


//         var qt = q.value
//         alert(qt);
//         varper1 = Number(p.value) 
//         varrt1 =Number(rt.value)
//          
//       
//          var varpercentage =(((Number(p.value)* Number(rt.value))/100)*Number(q.value)) + (Number(rt.value) * Number(q.value))
//          t.value = varpercentage
//          
//}



function checkfinal()
{
      alert("hi...")


var totalrow=5
//document.getElementById("ctl00$MyCPH1$roww").value
//alert(totalrow)
    var Formnae="ctl00_MyCPH1_GV_D_ctl"//02$txtoctamt"
    var total_octamt=0
    var octamount=0
    var GV_frmname="";
    for (var i=0;i<totalrow;i++ )
    {
         alert(i)
        j=i+2
        
        if(i<10)
        {
            GV_frmname=Formnae+"0"+j+"_"
            //GV_frmname1=Formnae+"0"+k+"$"
        }
        else
        {
        GV_frmname=Formnae+j+"_"
        //GV_frmname1=Formnae+k+"$"
        }
       
        qq=document.getElementById(GV_frmname+"txtqty").value
        pp=document.getElementById(GV_frmname+"txtperct").value
        
        rr=document.getElementById(GV_frmname+"txtrate").value
        tt=document.getElementById(GV_frmname+"txttot").value
        tt2=document.getElementById(GV_frmname+"txttottot").value
        
        
        
   var t =(((Number(pp.value)* Number(rr.value))/100)*Number(qq.value)) + (Number(rr.value) * Number(qq.value))
       
       tt.value=t;
        
 
}
}

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
    
function nwOpen()
        {
            window.open("popupLoc.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
         function nwOpen2(mNo)
        {
        //debugger
            window.open("popupasset.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
           function ValidateForm(obj){

  if (obj.value!="")
  {
    
	if (isDate(obj.value)==false){
	
		obj.focus()
		return false
	}
    return true
  }  
 }
    
     function ValidateData()
            {
           // debugger
                  if(document.getElementById("ctl00_MyCPH1_txtdesc"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtdesc").value == "")
                    {
                        alert("Enter Asset Description  ");
                        document.getElementById("ctl00_MyCPH1_txtdesc").focus();
                        return false;
                    }
              }   
              
              if(document.getElementById("ctl00_MyCPH1_txtprefix"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtprefix").value == "")
                    {
                        alert("Enter Asset Pre-fix");
                        document.getElementById("ctl00_MyCPH1_txtprefix").focus();
                        return false;
                    }
              }   
                if(document.getElementById("ctl00_MyCPH1_ddlassetgrp"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlassetgrp").value == "--Select--")
                    {
                        alert("Select Asset Group ");
                        document.getElementById("ctl00_MyCPH1_ddlassetgrp").focus();
                        return false;
                    }
                }
                if(document.getElementById("ctl00_MyCPH1_ddlunit"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlunit").value == "0")
                    {
                        alert("Select Asset Unit");
                        document.getElementById("ctl00_MyCPH1_ddlunit").focus();
                        return false;
                    }
                }
                
                
                   if(document.getElementById("ctl00_MyCPH1_ddlcat"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddlcat").value == "0")
                    {
                        alert("Select Asset Catagory");
                        document.getElementById("ctl00_MyCPH1_ddlcat").focus();
                        return false;
                    }
                }
                
                
              
              
              
              
              
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
    <div style="width: 10in">
        <table align="center" cellspacing="1" style="width: 80%" class="boxbg" border="0">
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
                    <asp:TextBox ID="txtpodt" Width="100" runat="server"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtpodt,'anchor2','dd/MM/yyyy'); return false;"
                        name="anchor2" id="a2">
                        <img src="./../../images/calendar.jpg" border="0"></img>
                    </a><font class="blackfnt">dd/mm/yyyy</font>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td>
                    <label class="blackfnt">
                        Vendor Code :</label></td>
                <td colspan="3">
                    <asp:TextBox ID="txtven" Width="100" runat="server"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen()">...</a>'
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
                    <asp:TextBox ID="txtqdt" Width="100" runat="server"></asp:TextBox>
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
                                BackColor="white" CssClass="boxbg" OnRowCreated="GV_D_OnRowDataBound" AutoGenerateColumns="False"
                                SelectedIndex="1">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO.">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" Width="50" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                            </asp:Label>
                                            <asp:CheckBox ID="chksrno" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Asset Code " HeaderStyle-Width="150">
                                        <HeaderStyle HorizontalAlign="Center" Width="100" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtassetcd" Width="60" runat="server" BorderStyle="Groove"></asp:TextBox><asp:Button
                                                ID="btncodepopup" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Asset Name ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" Width="150" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtastnm" Width="170" MaxLength="4" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtdesc" Width="150" TextMode="MultiLine" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Qty.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" Width="80" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtqty" Width="70" MaxLength="4" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="% Of Tax ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtperct" Width="70" MaxLength="4" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rate ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate" Width="70" MaxLength="4" onblur="javascript:return checkfinal()"
                                                onchange="javascript:return checkfinal()" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lll" Text="Total :" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Amount ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txttot" MaxLength="4" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox ID="txttottot" runat="server" BorderStyle="Groove"></asp:TextBox>
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
                    <asp:TextBox ID="txtadv" Width="70" MaxLength="4" runat="server" BorderStyle="Groove"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td colspan="3" style="width: 90%" align="Right">
                    <asp:Label ID="Label3" Text="Balance Amt. : " CssClass="blackfnt" Font-Bold="true"
                        runat="server"></asp:Label>
                </td>
                <td align="Right" style="height: 21px">
                    <asp:TextBox ID="txtbalamt" Width="70" MaxLength="4" runat="server" BorderStyle="Groove"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td>
                    <label class="blackfnt">
                        Requisition No. :
                    </label>
                </td>
                <td>
                    <asp:TextBox ID="txtreqno" Width="100" runat="server"></asp:TextBox>
                </td>
                <td>
                    <label class="blackfnt">
                        Requisition Date :</label></td>
                <td>
                    <asp:TextBox ID="txtreqdt" Width="100" runat="server"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtreqdt,'anchor2','dd/MM/yyyy'); return false;"
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
                        <br />
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
                                                <asp:ListItem>--Select--</asp:ListItem>
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
                    <asp:Button ID="btn_submit" Text="Submit" OnClick="btn_submit_Click" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <%-- <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>--%>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
         z-index: 99;">
    </div>
</asp:Content>
