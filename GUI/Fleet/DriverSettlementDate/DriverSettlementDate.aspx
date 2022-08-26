<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DriverSettlementDate.aspx.cs" Inherits="GUI_Fleet_DriverSettlementDate" Title="Driver Settlement Date" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">    
/*************************************************************************************************************
*   FOR NUMERIC TEXTBOX
/*************************************************************************************************************/
function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }

function CheckValidataion()
{
    var tb_Driver_Settlement_Date = document.getElementById("ctl00_MyCPH1_tb_Driver_Settlement_Date");
    var lbl_Driver_Settlement_Date_Err = document.getElementById("ctl00_MyCPH1_lbl_Driver_Settlement_Date_Err");
    
    if(tb_Driver_Settlement_Date.value == "")
    {
        tb_Driver_Settlement_Date.style.borderColor="red";
        lbl_Driver_Settlement_Date_Err.innerText="Enter Date!!!";
        tb_Driver_Settlement_Date.focus();
        return false;
    }
    else
    {
        lbl_Driver_Settlement_Date_Err.innerText = "";
    }
}

</script>

<%--<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
            <tr>
                <td align="right">
                    <img src="../../images/loading.gif" alt="" />
                </td>
                <td>
                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
            background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
            opacity: .50; -moz-opacity: .50;" runat="server">
            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                left: 50%;" ID="Panel2" runat="server">
            </asp:Panel>
        </asp:Panel>
    </ProgressTemplate>
</asp:UpdateProgress>--%>

<div align="left">
    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <br />
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Driver Settlement Date Entry</asp:Label>
                <hr />
                <br />    
            </td>
        </tr>
    </table>
    
    <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
        <ContentTemplate >
            <table id="tb_add" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="550">
                <tr id="RowNo" runat="server" bgcolor="white" visible="false" >
                    <td class="blackfnt" colspan="2" style="width: 30%"><strong>Driver Settlemnet Date</strong></td>
                    <td align="left" class="blackfnt" colspan="2" style="width: 50%">
                        <asp:TextBox ID="tb_Driver_Settlement_Date"  runat="server" Text="" BorderStyle="Groove" />
                         <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="tb_Driver_Settlement_Date"   runat="server">
                                        </ajaxToolkit:CalendarExtender>
                        <%--<asp:Image ID="img_Calendar" runat="server" BackColor="White" BorderColor="White" ForeColor="White" ImageUrl="~/GUI/images/calendar.jpg" />--%>
                        <asp:Label ID="lbl_Driver_Settlement_Date_Err" runat="server" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                    </td>
                    <td align="left" class="blackfnt" colspan="2" style="width: 20%">
                        <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return CheckValidataion()"  OnClick="btn_Submit_Click" />
                        <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" OnClick="btn_Cencel_Click" />
                    </td>
                </tr>
                 
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
        <ContentTemplate >
            <table id="Table1" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="550">
             <tr id="Tr1" runat="server" bgcolor="white">
                <td class="blackfnt" colspan="2" style="width: 38%">
                    <asp:GridView ID="gvDriverSettlementDate" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" Width="100%" AutoGenerateColumns="False" OnSelectedIndexChanged="gvDriverSettlementDate_SelectedIndexChanged" AllowPaging="True" OnPageIndexChanged="gvDriverSettlementDate_PageIndexChanged" OnPageIndexChanging="gvDriverSettlementDate_PageIndexChanging" PageSize="15">
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <PagerStyle BackColor="Silver" ForeColor="Black" HorizontalAlign="Center" Font-Bold="True" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="Gainsboro" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <HeaderTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" ForeColor="White"
                                        OnClick="lnk_btn_Add_Click" Text="Add New" Visible="false" ></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                        Text="Edit"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Driver Settlement Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblDriverSettlementDateId" runat="server" Text='<%# Bind("DriverSettlementDate") %>'></asp:Label>
                                    
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            
                        </Columns>
                        <PagerSettings Mode="NumericFirstLast" />
                    </asp:GridView>
                </td>
            </tr>
            </table>
            
              <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
            
            
        </ContentTemplate>
    </asp:UpdatePanel>
    
    
      
            
                
</div>
</asp:Content>

