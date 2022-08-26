<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="wfrmUpdateVehicleKM.aspx.cs" Inherits="VehicleKMUpdate" Title="Vehicle KM Update" %>

    
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<script language="javascript" type="text/javascript">
        function alterDisplay(txtid,lblid,hf_Col_Caption)
        {
            var tb_Col_Caption=document.getElementById(txtid);
            var lbl_Col_Caption=document.getElementById(lblid);
            var hf_Col_Caption=document.getElementById(hf_Col_Caption);
            if(tb_Col_Caption.style.display=='none')
               {
                    tb_Col_Caption.style.display="block";
                    lbl_Col_Caption.style.display="none";
                    tb_Col_Caption.focus();
                    tb_Col_Caption.select();
               }
            else
            {
                tb_Col_Caption.style.display="none";
                lbl_Col_Caption.style.display="block";
                lbl_Col_Caption.innerText=tb_Col_Caption.value;
                hf_Col_Caption.value=tb_Col_Caption.value;
            }
        }
        function OnMouseOut(lblid)
        {
            lblid.style.backgroundColor="Transparent"; 
            lblid.style.cursor='pointer';
            return true;
        }
        function OnMouseOver(lblid)
        {
            lblid.style.backgroundColor="#eff3ff"; 
            lblid.style.cursor='pointer';
            return true;
        }
        function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }

    </script>


 <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../../images/loading.gif" alt="" />
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
                        left: 50%;" ID="Panel21" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="True" runat="server">Update Vehicle Current KM Reading</asp:Label>
                <hr align="center" size="1"  color="#8ba0e5" />
            </td>
        </tr>
<%--        <tr style="background-color: white">
            <td align="right">
                <asp:ImageButton ID="imgbtnBack" OnClick="imgbtnBack_Click"   ImageUrl="~/Images/back.gif" runat="server" />
            </td>
        </tr>
        --%>
        
    </table>

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                        <ContentTemplate> 
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; height: 19px; text-align: center">
             
            </td>
          
        </tr>
        
        <tr>
            <td style="width: 100%; height: 19px; text-align: center;">
            
              <asp:Panel ID="Panel2" runat="server" Width="80%" style="text-align: left" >
            
              <table  class="boxbg" style="width: 96%" border="1"   cellpadding="0" cellspacing="0">
                    <tr style="width: 100%;" class="bgbluegrey" >
                        <td style="width: 10%; font-weight: bold; font-size: 8pt;  font-family: Verdana;  height: 26px; text-align: center;">
                        Sr. No.
                        </td>
                        <td style="width: 25%; font-weight: bold; font-size: 8pt;  font-family: Verdana;  height: 26px;">
                       <asp:TextBox ID="tb_Vehicle_No" CssClass="unwatermarked" AutoPostBack="true"  BorderStyle="Groove" 
                                    runat="server" ontextchanged="tb_Vehicle_No_TextChanged"></asp:TextBox>
                        <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" 
                        
                            TargetControlID="tb_Vehicle_No"  
                            WatermarkText="Enter Vehicle Like"
                            WatermarkCssClass="watermarked"  />
                        </td>
                        <td style="width: 25%; font-weight: bold; font-size: 8pt;  font-family: Verdana;  height: 26px;">
                        Current KM Reading
                        </td>
                        <td style="width: 30%; font-weight: bold; font-size: 8pt;  font-family: Verdana; height: 26px;">
                        KM Read
                        </td>
                    </tr>
                </table>
              
              </asp:Panel>
                
                <asp:Panel ID="Panel11" runat="server" Height="350px" Width="80%" ScrollBars="Vertical" style="text-align: left" >
        
           
                <asp:GridView ID="gv_Vehicle" runat="server" ShowHeader="false"   HeaderStyle-CssClass="blackfnt"  AutoGenerateColumns="False" CellPadding="3"
                    DataKeyNames="VEH_INTERNAL_NO"  Font-Names="Verdana" EmptyDataText="No Vehicle found."  Font-Size="8pt" Width="96%"  OnRowDataBound="gv_Vehicle_RowDataBound"  >
                     <HeaderStyle CssClass="GridHeader" />
                       <RowStyle CssClass="GridRow" HorizontalAlign="Center" />
                     <AlternatingRowStyle CssClass="GridAlternatingRow" />
                    <Columns>
                         <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="whitefnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                        <asp:TemplateField HeaderText="Vehicle Number"  >
                            <ItemTemplate>
                                <asp:HiddenField ID="hf_VEH_INTERNAL_NO" Value='<%# Bind("VEH_INTERNAL_NO") %>' runat="server" />
                                <asp:Label ID="lbl_Vehno" runat="server" Text='<%# Bind("VEHNO") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="25%" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Current KM Read"  >
                            <ItemTemplate>
                                <asp:Label ID="lbl_Current_KM" runat="server" Text='<%# Bind("CURRENT_KM_READ") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="25%" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="New KM Reading">
                            <ItemTemplate>
                                <asp:Label Width="225px"  ID="lbl_Tmp_Current_KM_Read" Text='<%# DataBinder.Eval(Container.DataItem,"Tmp_Current_KM_Read") %>'
                                    runat="server" CssClass="blackfnt" onmouseover="OnMouseOver(this)" onmouseout="OnMouseOut(this)" ></asp:Label>
                                <asp:Label ID="lblfixed" runat="server" CssClass="redfnt"></asp:Label>
                                <asp:HiddenField ID="hf_Tmp_Current_KM_Read" Value='<%# DataBinder.Eval(Container.DataItem,"Tmp_Current_KM_Read") %>'
                                    runat="server" />
                                <asp:TextBox ID="tb_Tmp_Current_KM_Read" Style="display: none;"  onkeydown="return numeric(event)" 
                                    Text='<%# DataBinder.Eval(Container.DataItem,"Tmp_Current_KM_Read") %>' Width="225px"
                                    MaxLength="50" runat="server" BorderStyle="Groove" CssClass="input"></asp:TextBox>
                            </ItemTemplate>
                             <ItemStyle Width="30%" HorizontalAlign="Left" />
                        </asp:TemplateField>
                        
                        
                        
                    </Columns>
                </asp:GridView>
              
        </asp:Panel>
       
            </td>
        </tr>
        <tr>
            <td style="vertical-align: middle; text-align: center; height: 23px;">
            
            <asp:Panel ID="Panel3" runat="server" Width="80%" style="text-align: left">
   <table class="boxbg" border="0" cellpadding="1" cellspacing="1" width="96%">
        <tr bgcolor="#eeeeee">
            <td class="blackfnt" colspan="1" align="center">
           
                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                    
                   
                </td>
        </tr>
    </table>
     </asp:Panel>
                </td>
        </tr>
    </table>

   <center>
        <font class="blackfnt" style="color: red"><b>
            <asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
    </ContentTemplate>
        </asp:UpdatePanel>
        
    

</asp:Content>

