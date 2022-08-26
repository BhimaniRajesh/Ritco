<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    EnableEventValidation="true" CodeFile="SAL_HEAD_MASTER.aspx.cs" Inherits="GUI_Finance_Fix_Asset_Fix_Asset_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();

     
//    function ValidateData(obj)
//    {
//    obj.value=
//    
//    }


function chnm(obj)
{
        var a;
        a=1;
        obj.value = obj.value.toUpperCase()
        
       for(i=0;i<str.length;i++)
       {
         var aaa=str[i].toUpperCase();
            if(obj.value==aaa)
            {
                a=2
                
                alert("Salary Head Name Already Exist....")
           obj.focus();
                break;
                //return false;
            }
            else
            {
                continue
            }
       }
 


}

function chpnm(obj)
 {
        var a;
        a=1;
        obj.value = obj.value.toUpperCase()
       for(i=0;i<str2.length;i++)
       {
 var aaa=str2[i].toUpperCase();
            if(obj.value==aaa)
            {
                a=2
                alert("Print Name Already Exist....")
           obj.focus();
                break;
                //return false;
            }
            else
            {
                continue
            }
 }
 


}
 
// this function assignment in keypress doesn't allow any special character other than alfa-num.
function validAlfaNum(event)
{
 
    if(event.keyCode==13)
        {
            return true;
        }
    if(event.keyCode<48)
    {
        event.keyCode=0;return false;
    }
    if(event.keyCode>122)
    {
        event.keyCode=0;return false;   
    }
    if(event.keyCode>92 && event.keyCode<97)
    {
        event.keyCode=0;return false;   
    }
    
    if(event.keyCode>57 && event.keyCode<65)
    {
        event.keyCode=0;return false;   
    }
}
 
function ValidateData()
{
// debugger
  
  var grid=document.getElementById("ctl00_MyCPH1_GV_D");
  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_D"
  var arrstr="";
  var q ="n";
  for(var b=2;b<=rows;b++)
  {
         var t_salhd="";
         var t_printname="";
         var d_type="";
         
         var t_shown="";
         var t_calbas="";
         var d_tds="";
         
        
        if(b<10)
        {
        //ddcalcbasis,ddtds,ddshoninsalslp,ddtype,txtprintname,txtsalhead_Desc
            
          t_calbas="ctl00_MyCPH1_GV_D_ctl0" + b + "_ddcalcbasis";
            d_tds="ctl00_MyCPH1_GV_D_ctl0" + b + "_ddtds";
            
             t_shown="ctl00_MyCPH1_GV_D_ctl0" + b + "_ddshoninsalslp";
           d_type="ctl00_MyCPH1_GV_D_ctl0" + b + "_ddtype";
            
             t_printname="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtprintname";
            t_salhd="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtsalhead_Desc";
            
        }
        else
        {
           
           t_calbas="ctl00_MyCPH1_GV_D_ctl" + b + "_ddcalcbasis";
            d_tds="ctl00_MyCPH1_GV_D_ctl" + b + "_ddtds";
            
             t_shown="ctl00_MyCPH1_GV_D_ctl" + b + "_ddshoninsalslp";
           d_type="ctl00_MyCPH1_GV_D_ctl" + b + "_ddtype";
            
             t_printname="ctl00_MyCPH1_GV_D_ctl" + b + "_txtprintname";
            t_salhd="ctl00_MyCPH1_GV_D_ctl" + b + "_txtsalhead_Desc";
            
        }
        
 
      
      
         var t_salhd2=document.getElementById(t_salhd);;
         var t_printname2=document.getElementById(t_printname);;
         var d_type2=document.getElementById(d_type);;
         
         var t_shown2=document.getElementById(t_shown);;
         var t_calbas2=document.getElementById(t_calbas);;
         var d_tds2=document.getElementById(d_tds);;
 
  
      
         
           
            if(t_salhd2.value!="")
            {
            q="y";
                    if(t_printname2.value=="")
                    {
                    
                        alert("Enter Print Name....")
                        t_printname2.focus();
                        return false;
                          
                    }
                    
                     if(d_type2.value=="NN")
                    {
                    
                        alert("Select Type....")
                        d_type2.focus();
                        return false;
                          
                    }
                    
                     if(t_shown2.value=="NN")
                    {
                    
                        alert("Enter To Be Shown In Salary Slip....")
                        t_shown2.focus();
                        return false;
                          
                    }
                    if(t_calbas2.value=="NN")
                    {
                    
                        alert("Select Salary Calculation Basis....")
                        t_calbas2.focus();
                        return false;
                          
                    }
                    if(d_tds2.value=="NN")
                    {
                    
                        alert("Select TDS Applicable....")
                        d_tds2.focus();
                        return false;
                          
                    }
                     
            } 
              
            
        
         
        

   } // END OF for

       if(q == "n")
        {
            alert("Please Enter Atleast One....")
            return false;
        }
   
     return true;
 
}
function validPODate(id)
{

    var txtdate=document.getElementById(id);
 if(txtdate.value != "")
    
        if(!isValidDate(txtdate.value,"Validity Date "))
            return false;
}


function calc()
 {
           // debugger
                
                
                var epf = document.getElementById("ctl00_MyCPH1_txtemppf").value - document.getElementById("ctl00_MyCPH1_txtpension").value
                
                document.getElementById("ctl00_MyCPH1_txtepf").value=epf;
                     
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


function nonenone(event,txtid)
{
 
var tb=document.getElementById(txtid);
var txt=tb.value;
if(event.keyCode==13)
return true;
 
event.keyCode=0;return false;
//}
}

    
//     function ValidateData()
//            {
//             if(document.getElementById("ctl00_MyCPH1_txtpfcd"))
//                {
//                    if(document.getElementById("ctl00_MyCPH1_txtpfcd").value == "")
//                    {
//                        alert("Enter PF Code ");
//                        document.getElementById("ctl00_MyCPH1_txtpfcd").focus();
//                        return false;
//                    }
//              }
//          
//                  if(document.getElementById("ctl00_MyCPH1_txtvaliditydt"))
//                {
//                    if(document.getElementById("ctl00_MyCPH1_txtvaliditydt").value == "")
//                    {
//                        alert("Enter Validate Date ");
//                        document.getElementById("ctl00_MyCPH1_txtvaliditydt").focus();
//                        return false;
//                    }
//              }
//              if(ch() == false)
//                 {
//                 return false;
//              }
//              }   
              
              function checklocation(obj)
        {
        var a;
        a=1;
        obj.value = obj.value.toUpperCase()
       for(i=0;i<str.length;i++)
       {

            if(obj.value==str[i])
            {
                a=2
                alert("PF Code Already Exist....")
           obj.focus();
                break;
                //return false;
            }
            else
            {
                continue
            }
       }
 


}
            
              
             
    
    
    
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>HR & Payroll</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Masters</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Salary Head Master</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>
            <div style="width: 10in">
                <asp:Panel ID="plnerr" Visible="false" runat="server">
                    <table width="90%">
                        <tr>
                            <td align="center">
                                <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                                <br />
                                <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                                <br />
                                <br />
                                <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnl1" runat="server">
                    &nbsp;<br />
                    <center>
                        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="40%" align="center">
                            <tr align="center" bgcolor="white">
                                <td align="center" style="width: 296px">
                                    <font class="blackfnt">Enter Row No *</font></td>
                                <td style="width: 121px">
                                    <asp:TextBox ID="roww" runat="server" Width="40px" MaxLength="2" Text="5" BorderStyle="Groove"
                                        AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25"></asp:TextBox></td>
                            </tr>
                        </table>
                        <br />
                    </center>
                    <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                        CellPadding="3" CellSpacing="1" BorderWidth="0" PagerStyle-HorizontalAlign="center"
                        CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="False" SelectedIndex="1">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Salary Head">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="100px" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" Width="150px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtsalhead_Desc" MaxLength="40" onkeypress="javascript:return validAlfaNum(event)" onblur="javascript:return chnm(this)"  runat="server" BorderStyle="Groove"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Print Name">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="100px" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" Width="150px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtprintname" MaxLength="40"   onkeypress="javascript:return validAlfaNum(event)"  onblur="javascript:return chpnm(this)"  runat="server" BorderStyle="Groove"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddtype" runat="server" Height="22px" Width="84px">
                                        <asp:ListItem Value="NN">--Select--</asp:ListItem>
                                        <asp:ListItem Value="E">Earning</asp:ListItem>
                                        <asp:ListItem Value="D">Deduction</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Wrap="true" HeaderStyle-Width="100" HeaderText="To Be Shown In Salary Slip">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddshoninsalslp" runat="server" Height="22px" Width="84px">
                                        <asp:ListItem Value="NN">--Select--</asp:ListItem>
                                        <asp:ListItem Value="Y">YES</asp:ListItem>
                                        <asp:ListItem Value="N">NO</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Wrap="true" HeaderStyle-Width="100" HeaderText="Salary Calculation Basis">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddcalcbasis" runat="server" Height="22px" Width="122px">
                                        <asp:ListItem Value="NN">--Select--</asp:ListItem>
                                        <asp:ListItem Value="CD">CALENDAR DAYS</asp:ListItem>
                                        <asp:ListItem Value="PD">PRESENT DAYS</asp:ListItem>
                                        <asp:ListItem Value="I">INDEPENDENT</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Wrap="true" HeaderText="TDS Applicable">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddtds" runat="server" Height="22px" Width="84px">
                                        <asp:ListItem Value="NN">--Select--</asp:ListItem>
                                        <asp:ListItem Value="Y">YES</asp:ListItem>
                                        <asp:ListItem Value="N">NO</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                    </asp:GridView>
                    <center>
                        <br />
                        <br />
                        <br />
                        <asp:Button ID="btn_submit" Text="Submit" Width="130" OnClick="btn_submit_Click"
                            runat="server" />
                    </center>
                </asp:Panel>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
        </Triggers>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
