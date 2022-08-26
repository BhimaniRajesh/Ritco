<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Leave_Master_Step1.aspx.cs" Inherits="GUI_HR_Payroll_Master_Leave_master_Leave_Master_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
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

function Submitdata()
    {
	    //debugger
	    Form_name="ctl00$MyCPH1$"  
        //maxrows=parseInt(document.getElementById(Form_name+"roww").value)
        var rows = document.getElementById("ctl00_MyCPH1_GV_D").rows.length
        var maxrows = document.getElementById("ctl00_MyCPH1_GV_D").rows.length
        var onecheck=false
		for(i=0;i<rows-1;i++)
        {
            //ctl00$MyCPH1$GV_D$ctl02$txtCityname
            //debugger
            
            j=i+2
            if (j<10)
            {
                if (document.getElementById("ctl00_MyCPH1_GV_D_ctl0"+j+"_txtLeaveName").value != "")
                {
                    onecheck=true
                }
            }
            else
            {
                //document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtCityname").disabled=false
                if (document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtLeaveName").value != "")
                {
                    onecheck=true
                }
            }    
        }
        if (onecheck == false) 
        {
            alert("Please Enter Atlist One Leave Name")
            return false;
        }
        if (maxrows>=1)
        {
		     for(i=0;i<maxrows-1;i++)
			 {
			     j = i + 2;
	           
	            if(i < 10)
                {
                                       
                    frm3=Form_name+"GV_D$ctl"+"0"+j+"$"
                }
                else
                {
                    frm3=Form_name+"GV_D$ctl"+j+"$"
                   
                }
                   
             
			   if (document.getElementById(frm3+"txtLeaveName").value!="")		
			   {
				 if(document.getElementById(frm3+"txtLeaveDesc").value=="")
				  {
				   alert("Please Enter Description")
				   document.getElementById(frm3+"txtLeaveDesc").focus();
				   return false;
				  }
				  if(document.getElementById(frm3+"txtLeaveLimit").value=="")
				  {
				   alert("Please Enter Carry Over Limit")
				   document.getElementById(frm3+"txtLeaveLimit").focus();
				   return false;
				  }
			   }
			}
	  }
	    
        
}

function checkcode(obj)
                        { 
                            var a;
                            a=1;
                           
                            obj.value = obj.value.toUpperCase()
                            for(i=0;i<str.length;i++)
                                {
                                if(obj.value==str[i])
                                    {
                                        a=2
                                        alert("Leave Code Already Exist.You can not Enter with this Code...")
                                        obj.focus();
                                        return false
                                    }
                                }
                         }
                         
//function checkcodeEdit(obj)
//                        { 
//                            var a;
//                            a=1;
//                            obj.value = obj.value.toUpperCase()
//                            for(i=0;i<str.length;i++)
//                                {
//                                if(obj.value==str[i])
//                                    {
//                                        if (a==1)
//                                        {
//                                        a=2;
//                                        continue;
//                                        }
//                                        if(a==2)
//                                        {
//                                        alert("Leave Code Already Exist.You can not Enter with this Code...")
//                                        obj.focus();
//                                        return false
//                                        }
//                                        
//                                    }
//                                }
//                         }
    </script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">HR & Payroll :- Masters</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                <div align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../../images/back.gif" border="0" alt="" /></a></div>
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>HR & Payroll :- </b></font><font class="bluefnt"><b>Leave
                    Masters</b> </font>
            </td>
        </tr>
        <tr bgcolor="white">
            <td>
                <asp:UpdatePanel ID="DataGrid2_Update" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <table runat="server" id="tblrow" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            align="center">
                            <tr runat="server" id="trrow" bgcolor="white">
                                <td align="left">
                                    <font class="bluefnt">Enter Row No *</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="roww" onkeypress="return validInt(event)" runat="server" Width="30px"
                                        BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25">
                                    </asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <div align="left">
                            <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                                CellPadding="3" CellSpacing="1" BorderWidth="0" PagerStyle-HorizontalAlign="left"
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
                                    <asp:TemplateField HeaderText="Leave Code" HeaderStyle-HorizontalAlign="center">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="80px" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" HorizontalAlign="center" CssClass="blackfnt" Width="100px" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtLeaveName" runat="server" Width="50" MaxLength="25" BorderStyle="Groove"></asp:TextBox>
                                            <asp:HiddenField ID="HidLeaveName" runat="server" />
                                            <%--<atlas:AutoCompleteExtender ID="Extender1" runat="server">
                                                <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCItyList"
                                                    ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtLeaveName" />
                                            </atlas:AutoCompleteExtender>--%>
                                            <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True"
                                                MinimumPrefixLength="1" ServiceMethod="GetCItyList"
                                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtLeaveName">
                                            </ajaxToolkit:AutoCompleteExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description" HeaderStyle-HorizontalAlign="center">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="80px" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" HorizontalAlign="center" CssClass="blackfnt" Width="100px" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtLeaveDesc" runat="server" Width="100" MaxLength="100" BorderStyle="Groove"></asp:TextBox>
                                            <asp:HiddenField ID="HidLeaveDesc" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Affects Salary">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="ChkAffectSalary" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle BackColor="white" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Carry Over">
                                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemStyle BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkCarryOver" runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Carry Over Limit" HeaderStyle-HorizontalAlign="center">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="false" Width="100px" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" HorizontalAlign="center" CssClass="blackfnt" Width="100px" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtLeaveLimit" runat="server" Text="0" Width="50" MaxLength="9"
                                                BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgbluegrey" />
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
                <br />
                <div align="center" style="width: 10in">
                    <asp:Button ID="Button11" OnClientClick="javascript:return Submitdata()" OnClick="Button11_Click"
                        runat="server" Text="Submit" TabIndex="9" />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
