<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    EnableEventValidation="true" CodeFile="PF_MASTER.aspx.cs" Inherits="GUI_Finance_Fix_Asset_Fix_Asset_Add" %>

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

    
     function ValidateData()
            {
             if(document.getElementById("ctl00_MyCPH1_txtpfcd"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtpfcd").value == "")
                    {
                        alert("Enter PF Code ");
                        document.getElementById("ctl00_MyCPH1_txtpfcd").focus();
                        return false;
                    }
              }
          
                  if(document.getElementById("ctl00_MyCPH1_txtvaliditydt"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtvaliditydt").value == "")
                    {
                        alert("Enter Validity Date ");
                        document.getElementById("ctl00_MyCPH1_txtvaliditydt").focus();
                        return false;
                    }
              }
              }   
              
                
              
             
    
    
    
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>HR & Payroll</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Masters</b></font></a> <b>&gt; </b><font class="bluefnt"><b>PF Master</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:UpdatePanel ID="up3" runat="server">
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
                    <table align="center" cellspacing="1" style="width: 80%" class="boxbg" border="0">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       PF Master
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td>
                                <label class="blackfnt">
                                    PF Code :
                                </label>
                            </td>
                            <td>
                                <%-- <asp:Label ID="txtpfcd" CssClass="blackfnt"  ForeColor="red" runat="server">
                                      &lt System Generated... &gt
                    </asp:Label></td>--%>
                                <asp:TextBox ID="txtpfcd" MaxLength="25" onkeypress="javascript:return validAlfaNum(event)" runat="server"></asp:TextBox></td>
                            <td>
                                <label class="blackfnt">
                                    Validity Date :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtvaliditydt" onblur="javascript:return validPODate(this.getAttribute('id'));"
                                    runat="server"></asp:TextBox><a href="#" onclick="cal.select(ctl00$MyCPH1$txtvaliditydt,'anchor3','dd/MM/yyyy'); return false;"
                                        name="anchor3" id="a3">
                                        <img src="./../../images/calendar.jpg" border="0"></img>
                                    </a>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" Font-Bold="true"
                        runat="server" ControlToValidate="txtvaliditydt" ErrorMessage="*" EnableClientScript="true" SetFocusOnError="true" Display="static"    Width="1px"></asp:RequiredFieldValidator>--%>
                                &nbsp &nbsp<font class="blackfnt">dd/mm/yyyy</font></td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td>
                                <label class="blackfnt">
                                    Maximum Age Limit :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtmaxage" MaxLength="2" Text="65" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    runat="server"></asp:TextBox></td>
                            <td>
                                <label class="blackfnt">
                                    PF Salary Limit :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtpfsallimit" Text="6500" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    runat="server"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td colspan="4" align="left" style="height: 21px">
                                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       Employee's Contribution
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td>
                                <label class="blackfnt">
                                    Employee's PF (A) :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtemppf" onblur="javascript:calc()" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    Text="12" runat="server"></asp:TextBox></td>
                            <td colspan="2">
                                <label class="blackfnt">
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td colspan="4" align="left" style="height: 21px">
                                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       Employer's Contribution
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td>
                                <label class="blackfnt">
                                    Pension Found (B) :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtpension" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    onblur="javascript:calc()" Text="8.33" runat="server"></asp:TextBox></td>
                            <td>
                                <label class="blackfnt">
                                    Inspection Charges :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtinspchg" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    Text="0.50" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td>
                                <label class="blackfnt">
                                    EPF %(A-B) :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtepf" Text="3.63" onkeypress="javascript:return nonenone(event,this.getAttribute('id'));"
                                    runat="server"></asp:TextBox></td>
                            <td>
                                <label class="blackfnt">
                                    EDLI % :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtedli" Text="1.10" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    runat="server"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: #ffffff">
                            <td colspan="2">
                            </td>
                            <td>
                                <label class="blackfnt">
                                    Administration Charges % :
                                </label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtadminchg" Text="0.01" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                    runat="server"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td colspan="4" align="center" style="height: 21px">
                                <asp:Button ID="btn_submit" Text="Submit" Width="130" OnClick="btn_submit_Click"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
