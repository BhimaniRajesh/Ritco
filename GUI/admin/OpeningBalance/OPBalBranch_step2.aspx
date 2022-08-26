<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" EnableViewState="true"
    CodeFile="OPBalBranch_step2.aspx.cs" Inherits="GUI_admin_OpeningBalance_OPBalBranch_step2" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MyCPH1">

    <script language="javascript" type="text/javascript">
        function chk(obj,val1,val2)
        {
            txtval1=document.getElementById(val1);
            txtval2=document.getElementById(val2);
            
            if(parseFloat(txtval1.value) != 0 && parseFloat(txtval2.value) != 0)
            {
                alert("Either 'Opening Credit' or 'Opening Debit' value should be Zero");
                document.getElementById(obj.name).value = "0.00"
                return false;
            }
        }
//        function chk1(obj,val1,val2)
//        {
//            alert(obj.value)
//            alert(val2)
//        }

/*************************************************************************************************************
            function assignment in keypress doesn't allow any character other than number
*************************************************************************************************************/

 
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
function CheckData()
{
    var CheckBox = "N";
    var tbl=document.getElementById("ctl00_MyCPH1_myGrid");
    var rows=tbl.rows.length;
    for(i = 2; i < rows ; i++)
    {
        if(i<10)
        {
            chk=document.getElementById("ctl00_MyCPH1_myGrid_ctl0" + i + "_chk");
            txtOp_Cr=document.getElementById("ctl00_MyCPH1_myGrid_ctl0" + i + "_txtOpenBal");
            txtOp_Dr=document.getElementById("ctl00_MyCPH1_myGrid_ctl0" + i + "_txtCloseBal"); 
        }
        else
        {
            chk=document.getElementById("ctl00_MyCPH1_myGrid_ctl" + i + "_chk");
            txtOp_Cr=document.getElementById("ctl00_MyCPH1_myGrid_ctl" + i + "_txtOpenBal");
            txtOp_Dr=document.getElementById("ctl00_MyCPH1_myGrid_ctl" + i + "_txtCloseBal");
        }
        if(chk.checked)
        {
            CheckBox = "Y";
            if(parseFloat(txtOp_Cr.value) == 0 && parseFloat(txtOp_Dr.value) == 0)
            {
                alert("Plz Enter Either Debit Or Credit Amount");
                return false;
            }
            if(parseFloat(txtOp_Cr.value) > 0 && parseFloat(txtOp_Dr.value) > 0)
            {
                alert("Plz Enter Either Debit Or Credit Amount");
                return false;
            }
        }
    }
    if(CheckBox == "N")
    {
        alert("Plz Select The Account Code");
        return false;
    }
    //alert("Done")
    return true;
}
    </script>

    <br />
    <strong><span style="text-decoration: underline"></span></strong>
    <b><asp:Label ID="Label1" runat="server" CssClass="blackfnt" style="font-weight: bold; text-decoration: underline"></asp:Label></b><br /><br />
    <div align="left">
        <asp:UpdatePanel ID="ud1"  UpdateMode="Always" RenderMode="Inline" runat="server">
            <ContentTemplate>
            <table border="0" cellpadding="2" cellspacing="1" class="boxbg">
        <tr>
            <td bgcolor="white" align="center">
                <asp:DataGrid ID="myGrid" AutoGenerateColumns="False" runat="server" CssClass="blackfnt" PageSize="5000" ShowFooter="True" HeaderStyle-CssClass="bgbluegrey" OnItemDataBound="myGrid_ItemDataBound" OnPageIndexChanged="myGrid_SelectedIndexChanged">
                    <Columns>
 
                        <asp:TemplateColumn>
                            <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" text ="<%#Container.DataSetIndex+1 %>" runat="server" CssClass="blackfnt">
                                 </asp:Label>
                                <asp:CheckBox ID="chk" runat="server"   Checked="false" />
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateColumn>
                        
                        <asp:TemplateColumn HeaderText="Account Code"    HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAcct_Code"  CssClass="blackfnt" runat="server" BorderStyle="None" ReadOnly="true" Width="90"></asp:TextBox>
                                <asp:HiddenField ID="hdn_acccode" runat="server" />
                            </ItemTemplate>
                            <ItemStyle Font-Bold="False" Font-Italic="False" CssClass="blackfnt" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" Wrap="False" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateColumn>
                        
                        <asp:TemplateColumn HeaderText="Account Description"    HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAcct_Desc" CssClass="blackfnt"  runat="server" BorderStyle="None" Width="250" ReadOnly="true"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="False" Font-Italic="False" CssClass="blackfnt" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" Wrap="False" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateColumn>
                        
                        <asp:TemplateColumn HeaderText="Cummulative (Credit)"     HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <ItemTemplate>
                                <asp:TextBox ID="txtOp_Cr_Cu"  CssClass="blackfnt" runat="server" BorderStyle="none"   Width="80" Style="text-align: right" ReadOnly="true"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" Wrap="False" BackColor="#CCCCCC" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateColumn>
                        
                       
                        <asp:TemplateColumn HeaderText="Individual (Credit)"     HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <ItemTemplate>
                                <asp:TextBox ID="txtOp_Cr_In"  CssClass="blackfnt" runat="server" BorderStyle="Groove"  Width="80" Style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" Wrap="False" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateColumn>
                        
                         <asp:TemplateColumn HeaderText="Cummulative (Debit)"     HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <ItemTemplate>
                                <asp:TextBox ID="txtOp_Dr_Cu"  CssClass="blackfnt" runat="server" BorderStyle="none" Style="text-align: right"   Width="80" ReadOnly="true"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" Wrap="False" BackColor="#CCCCCC"/>
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateColumn>
                        
                        <asp:TemplateColumn HeaderText="Individual (Debit)"     HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <ItemTemplate>
                                <asp:TextBox ID="txtOp_Dr_In" CssClass="blackfnt"  runat="server" BorderStyle="Groove" Style="text-align: right" Width="80"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" Wrap="False" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateColumn>
                        
                        <asp:TemplateColumn HeaderText="Individual (Credit)"     HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtOpenBal" CssClass="blackfnt" runat="server" BorderStyle="groove" Style="text-align: right" Width="90"></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        
                        <asp:TemplateColumn HeaderText="Individual (Debit)"     HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCloseBal" CssClass="blackfnt" runat="server" BorderStyle="groove" Style="text-align: right" Width="90"></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Fin. Year"     HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
                                <ItemTemplate>
                                    <asp:Label ID="lblFinYear" runat="server" CssClass="blackfnt"></asp:Label>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                    
                    </Columns>
                    
                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" />
                    <PagerStyle Mode="NumericPages" />
                </asp:DataGrid>
                <br />
               
                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" OnClientClick="javascript:return CheckData();" /> <br /></td>
        </tr>
       </table>
            </ContentTemplate>
        </asp:UpdatePanel>
       
    </div>
</asp:Content>
