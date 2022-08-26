<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="EnterNews.aspx.cs" Inherits="GUI_admin_Updates_UpdateNews" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script type="text/javascript" language="javascript">
function setRowNum(str,pansel)
{
    var colorpan=document.getElementById("ctl00_MyCPH1_divcolorpan");
    var hdn=document.getElementById("ctl00_MyCPH1_hdncolor");
    colorpan.style.display='block';
    hdn.value=str;
    
     var curleft=0,curtop=0;
    var colorbar=document.getElementById(pansel);
  
     if(colorbar.offsetParent)
       {
            curleft+=colorbar.offsetLeft;
            curtop+=colorbar.offsetTop;
            while(colorbar.offsetParent)
            {
                colorbar=colorbar.offsetParent;
                curleft+=colorbar.offsetLeft;
                curtop+=colorbar.offsetTop;
            }
       }
      
    
    colorpan.style.left= (curleft + 60) + 'px';
    var t1=curtop+15;
    colorpan.style.top= t1 + 'px';
   return false;
}


</script>

<div align="center">

                                 <%--Back Link To First Page in Viewing Agent Bills--%>
    
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img border="0" src="../../images/back.gif" /></a>
            </td>
        </tr>
    </table>
    

<br /><br />

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="center">Enter News Updates</td>
        </tr>
    </table>

<br />

    
   
        
    
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" width="50%">Enter No. of Rows</td>
            <td class="blackfnt" align="left" width="50%">
                <asp:TextBox runat="server" ID="txtnorows"></asp:TextBox>
                <asp:Button runat="server" Text="Add Rows" OnClick="btnrows_Click" ID="btnrows" />
            </td>
        </tr>
    </table>

<br />

  <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">Document Details</td>
        </tr>

<tr bgcolor="#ffffff">
    <td class="blackfnt" align="left">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
        <asp:GridView CssClass="boxbg" runat="server" ID="grvcontrols" AllowPaging="true" Width="100%"
                AllowSorting="true" PagerStyle-HorizontalAlign="left"
                BackColor="white" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnRowDataBound="grvcontrols_RowDataBound">
             <Columns>
  
                <asp:TemplateField HeaderText="Sr. No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                            </ItemTemplate>
                </asp:TemplateField>
        
                
                 <asp:TemplateField HeaderText="Head Line">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtheadline" runat="server"></asp:TextBox>
                            </ItemTemplate>
                 </asp:TemplateField>
            
                 <asp:TemplateField HeaderText="News">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtnews" runat="server"></asp:TextBox>
                                <asp:TextBox ID="txtnews_colorname" style="display:none;" runat="server"></asp:TextBox>
                            </ItemTemplate>
                 </asp:TemplateField>
            
                <asp:TemplateField HeaderText="Select Color">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                            <asp:Button ID="btncolbar" BorderStyle="Groove" runat="server" BackColor="black" Width="100px" Height="15px" />
                            </ItemTemplate>
                 </asp:TemplateField>
            </Columns>
        </asp:GridView>
        
                  <asp:Panel runat="server" ID="divcolorpan" style="top:200px;display:none;position:absolute; background-color:White;border:solid 1px black;size:auto;">
                    <asp:Table runat="server" ID="tblcolorpan" style="margin:2px 2px 2px 2px;">
                     
                    </asp:Table>
                </asp:Panel>
                
                
        </ContentTemplate>
    </asp:UpdatePanel>
      </td>
</tr>
<tr bgcolor="#ffffff">
    <td class="blackfnt">
        <asp:Button runat="server" OnClick="btnsubmit_Click" Text="Submit" ID="btnsubmit"></asp:Button>
    </td>
</tr>     
</table>
    <asp:HiddenField ID="hdncolor" runat="server" />
    <asp:HiddenField ID="hdnrows" runat="server" Value="5" />
</div>


</asp:Content>
