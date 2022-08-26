<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GodownMaster.aspx.cs" Inherits="GUI_admin_Godown_Master_GodownMaster" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript">
/*************************************************************************************************************
*   CHECK GODOWN NAME ALREADY ENTER FOR LOCATION
/*************************************************************************************************************/        
function checkGodown(obj)
{ 
     var Prefix;
     var gvGodown = document.getElementById("ctl00_MyCPH1_gvGodown");  
     var rows = gvGodown.rows.length;
            
     for(i=0;i<rows-1;i++)
     {        
            j=i+2;                   
            if (j<10)                                  
                Prefix = "ctl00_MyCPH1_gvGodown_ctl0"+ j;   
            else           
                Prefix = "ctl00_MyCPH1_gvGodown_ctl"+ j;   
            
            var txtGodownName = document.getElementById(Prefix + "_txtGodownName");  
            
            if(obj.id != Prefix + "_txtGodownName")
            {  
                   if(txtGodownName.value.toUpperCase() == obj.value.replace(/^\s+|\s+$/g, '').toUpperCase())
                   {
                        alert("Warehouse name already entered in this location.");  
                        obj.value = "";
                        obj.focus();  
                        return false;
                   }
            }     
      }     
}

function btnAddRows()
{
        var txtAddRows = document.getElementById("ctl00_MyCPH1_txtAddRows"); 
        var ddlLocation = document.getElementById("ctl00_MyCPH1_ddlLocation");
        
        if(ddlLocation.value == "0")
        {
              alert("Please select location first.");
              txtAddRows.focus();
              return false;
        }  
        else
        {        
                if(txtAddRows.value == "")
                {
                        alert("Please Enter Number of rows.");                        
                        return false;
                }
                else
                {
                    if(parseInt(txtAddRows.value) <= 0)
                    {
                        alert("Please Enter Positive Number.");                       
                        return false;
                    }
                }
         }
        return true;
}


/*************************************************************************************************************
*   VALIDATION FOR ALL INPUT WHEN SUBMIT BUTTON CLICK
/*************************************************************************************************************/             
function btnSubmitCheck()
{          
       var Prefix;
       var gvGodown = document.getElementById("ctl00_MyCPH1_gvGodown");  
       var rows = gvGodown.rows.length;
           
       for(i=0;i<rows-1;i++)
       {        
            j=i+2;                   
            if (j<10)                                   
                Prefix = "ctl00_MyCPH1_gvGodown_ctl0"+ j;   
            else          
                Prefix = "ctl00_MyCPH1_gvGodown_ctl"+ j;              
          
            var txtGodownName = document.getElementById(Prefix + "_txtGodownName");  
            var txtDescription = document.getElementById(Prefix + "_txtDescription");  
            
            if(txtGodownName.value.replace(/^\s+|\s+$/g, '') != "")
            {
                if(txtDescription.value.replace(/^\s+|\s+$/g, '') == "")
                { 
                   alert("Please enter description.");
                   txtDescription.focus();
                   return false; 
                }
            }     
         }
               
       if(!confirm("Are you sure you want to Submit this Record ?"))
            return false;
            
        return true;         
}
    </script>

    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <table align="center" border="0" cellpadding="2" cellspacing="1" width="75%" class="boxbg">
            <tr class="bgbluegrey">
                <td colspan="2" align="center" style="font-weight: bold" class="blackfnt" height="20px">
                    <b>WAREHOUSE MASTER</b></td>
            </tr>
            <tr>
                <td colspan="2" bgcolor="#FFFFFF">
                    <table border="0" cellspacing="1" width="100%">
                        <tr>
                            <td align="right" class="blackfnt">
                                Warehouse Location Code</td>
                            <td>
                                <asp:DropDownList ID="ddlLocation" CssClass="blackfnt" runat="server" Width="175px"
                                    TabIndex="1" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="bgwhite">
                <td height="15px">
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="center" colspan="2">
                    <asp:Label ID="label1" Text="Enter Number Of Rows" runat="server" CssClass="blackfnt"></asp:Label>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:TextBox ID="txtAddRows" runat="server" style="text-align:right" onkeypress="javascript:return validInt(event);"
                                CssClass="blackfnt" BorderStyle="Groove"
                                Width="44px"></asp:TextBox>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlLocation" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Button ID="CmdAddRows"  OnClientClick="Javascript:return btnAddRows();" runat="server" Text="Add Rows" CssClass="blackfnt" Width="66px"
                        OnClick="CmdAddRows_Click" />
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:GridView ID="gvGodown" BorderWidth="0" CellSpacing="1" runat="server" AutoGenerateColumns="false"
                                Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgwhite"
                                OnRowDataBound="gvGodown_RowDataBound" PagerSettings-Mode="NumericFirstLast"
                                PageSize="10" SelectedIndex="1">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No." ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                                runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="250" HeaderText="Warehouse Name" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtGodownName" Width="337" CssClass="blackfnt" BorderStyle="Groove"
                                                MaxLength="48" Onblur="Javascript:this.value=this.value.toUpperCase();" runat="server" Text='<%# Eval("godown_name") %>'></asp:TextBox>
                                                <asp:HiddenField ID="hdfGodownNo" Value='<%# Eval("godown_srno") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="250" HeaderText="Description" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDescription" Width="337" CssClass="blackfnt" BorderStyle="Groove"
                                                Onblur="Javascript:this.value=this.value.toUpperCase();" MaxLength="98" runat="server"
                                                Text='<%# Eval("godown_desc") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="150" HeaderText="Area in Square Feet" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtArea" Width="150" CssClass="blackfnt" BorderStyle="Groove"
                                                Onblur="Javascript:this.value=this.value.toUpperCase();" MaxLength="98" runat="server"
                                                Text='<%# Eval("Area") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField ItemStyle-Width="150" HeaderText="Address" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtAddress" Width="150" CssClass="blackfnt" BorderStyle="Groove"
                                                Onblur="Javascript:this.value=this.value.toUpperCase();" MaxLength="98" runat="server"
                                                Text='<%# Eval("GodownAddress") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField ItemStyle-Width="150" HeaderText="Validity Date" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>               
                                            <asp:TextBox ID="txtValidityDate" Width="150" CssClass="blackfnt" BorderStyle="Groove"
                                                runat="server"  Text='<%# Eval("ValidityDate") %>'></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtValidityDate" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="35px" HeaderText="Active Flag" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkActiveFlag" runat="server" CssClass="blackfnt" Checked="True" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlLocation" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="blackfnt" OnClick="btnSubmit_Click" OnClientClick="javascript:return btnSubmitCheck()" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="ddlLocation" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
