<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GodownMASTER.aspx.cs" Inherits="GUI_admin_Godown_Master_GodownMASTER" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript" type="text/javascript">
function checkrows()
{
    if (document.getElementById("ctl00_MyCPH1_TxtRows").value == "")
    {
        alert("Plaese Enter Valid Number Of Rows !!")
        return false;
    }
}
var txtval
function getvalue(obj)
{
    //debugger
    //txtval = obj.value
    //ctl00_MyCPH1_GrdPaidFollow_ctl03txtgname
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
function chkgodawn(obj)
        {   
            //debugger
            obj.value = trimAll(obj.value);   
            var rows = document.getElementById("ctl00_MyCPH1_GrdPaidFollow").rows.length;
            for(i=0;i<rows-1;i++)
            {
                j=i+2
                if (j<10)
                {
                        
                       if(obj.id != "ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtgname")
                       {     
                           if(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtgname").value == obj.value && document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtgname").value != "")
                           {
                                alert("Godawn name already entered in this location !!")  
                                obj.value=""
                                obj.focus()  
                                return false
                           }
                       }             
                }
                else
                {
                       if(obj.id != "ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtgname")
                       {
                           if(document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtgname").value == obj.value && document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtgname").value != "")
                           {
                                alert("Godawn name already entered in this location !!")    
                                obj.value=""
                                obj.focus()  
                                return false
                           }         
                       }    
                }
           }     
        }
function Nagative_Chk_wDecimal(obj)
        {
            //alert(obj)
            var a = document.getElementById(obj).value 
	        //var temp = trimAll(a) 
        	//alert("Hiiiiiiiiii")
	        if (a == "")	
	        {
		        /*alert("Value can not be blank")
		        obj.focus();
		        return false;*/
		        return true;
	        }
        	
	        if(isNaN(a))
	        {
		        alert("Value should be Numeric")
		        document.getElementById(obj).focus();
		        return false;
	        } 				
        		  
	        if(parseFloat(a) < 0)
	        {
		        alert("Value should be greater than zero")
		        document.getElementById(obj).focus();
		        return false;
	        }
        	
	        //document.getElementById(obj).value=roundit(a) 
        	
	        return true;					   
        }
        function uppercase(obj)
        {
           obj.value = obj.value.toUpperCase()
           //obj2.value = obj2.value.toUpperCase()  
        }
//        function abc()
//        {
//           debugger;
//           if (window.event.keyCode == 13)
//            {
//                event.returnValue=false;
//                event.cancel = true;
//            }
//        }
    </script>

    <br />
    <div align="left">
        <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
            <b>Administrator</b></font></a> <b>&gt; </b><a href="../operations.aspx"><font class="blklnkund">
                <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Godown Master</b></font></div>
    <div align="right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img src="../../images/back.gif" border="0" alt="" /></a>
    </div>
    <br />
    <br />
    <table align="center" border="0" cellpadding="2" cellspacing="1" width="75%" class="boxbg">
        <tr class="bgbluegrey">
            <td colspan="3" align="center">
                <font class="blackfnt"><b>GODOWN MASTER SCREEN</b></font></td>
        </tr>
        <tr>
            <td colspan="3" bgcolor="#FFFFFF">
                <table border="0" cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td valign="top" style="width: 297px">
                            <font class="blackfnt">Godown Location Code :</font></td>
                        <td colspan="1">
                            <asp:UpdatePanel ID="upRptLoc" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cboLocationCode" runat="server" Width="175px" TabIndex="3"
                                        AutoPostBack="true" OnSelectedIndexChanged="cboLocationCode_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <%--<Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cboLocationCode" EventName="SelectedIndexChanged" />
                                    </Triggers>--%>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblerror" runat="server" ForeColor="Red" Text="Please Select Location Code"
                                        Visible="False" Width="330px"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cboLocationCode" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div align="center">
        <br />
        <table border="1" cellspacing="0" cellpadding="3">
            <tr>
                <td valign="top">
                    <asp:Label ID="label1" Text="Enter Number Of Rows :" runat="server" CssClass="blackfnt"></asp:Label>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server"     UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:TextBox ID="TxtRows" runat="server" onblur="Nagative_Chk_wDecimal('ctl00_MyCPH1_TxtRows')"
                                CssClass="blackfnt" Width="44px"></asp:TextBox><%--onblur="Nagative_Chk_wDecimal('ctl00_MyCPH1_TxtRows')"--%>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboLocationCode" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td valign="top">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Button ID="CmdAddRows" OnClientClick="return checkrows()" runat="server" Text="Add Rows"
                                Width="66px" OnClick="CmdAddRows_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div align="center">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <asp:GridView ID="GrdPaidFollow" PagerStyle-Mode="NumericPages" CssClass="boxbg"
                    PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" BackColor="white"
                    runat="server" SelectedIndex="1" OnRowCreated="GrdPaidFollow_RowCreated" OnRowDataBound="GrdPaidFollow_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="337" HeaderText="Godawn Name">
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtgname" Width="337" MaxLength="50" runat="server" Text='<%# Eval("godown_name") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="337" HeaderText="Description">
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtgdesc" Width="337" MaxLength="100" runat="server" Text='<%# Eval("godown_desc") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="cboLocationCode" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <br />
    <table border="0" cellspacing="2" cellpadding="4" width="50%" align="center">
        <tr>
            <td align="center">
                <asp:UpdatePanel ID="UpdatePanel5" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                            UseSubmitBehavior="False" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="cboLocationCode" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
