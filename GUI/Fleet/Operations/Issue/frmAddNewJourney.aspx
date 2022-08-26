<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmAddNewJourney.aspx.cs" Inherits="Issue_frmAddNewJourney" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<p align="center">


                        
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">TRIP SHEET - JOURNEY DETAILS</asp:Label>
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
    <%--<hr align="center" size="1" color="#8ba0e5" />--%>
      <br> 
      
      <table cellspacing="1" cellpadding="3" style="width: 95%" align=center class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="8" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor=red></asp:Label></td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="TRIP SHEET - JOURNEY DETAILS"></asp:Label></td>
                           
                    
            </tr>
            <tr style="background-color: white">
                <td width="10%"><font class=blackfnt>Enter no. of rows</font></td>
                <td align=left><asp:TextBox ID="txtAddRow" runat=server MaxLength="3" Width="30" BorderStyle="Groove" OnTextChanged="add_row" AutoPostBack=true></asp:TextBox></td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan=2 align=center>
                 <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel3" Visible="true">
                              <table border="0" Width="100%">
                                 <tr>
                                    <td>
                                    
                                    <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False" OnItemDataBound="DataGrid1_ItemDataBound"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" >
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Station &amp; Distance">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtStation_Distance" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqStation_Distance" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtStation_Distance"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Arrival/Departure">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="cboArrival_Departure" runat=server>
                                                                  <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                                                  <asp:ListItem Value="A" Text="Arrival"></asp:ListItem>
                                                                  <asp:ListItem Value="D" Text="Departure"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="reqArrival_Departure" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboArrival_Departure"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Arrival/Departure Date">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtArrvDepDt" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                  <asp:RequiredFieldValidator ID="reqArrvDepDt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtArrvDepDt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVArrvDepDt" runat="server" ControlToValidate="txtArrvDepDt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Arrival/Departure Time">
                                                            <ItemTemplate>
                                                             <%--<cboTime:cboTime ID="cboTime1" runat="server" />--%>
                                                              <asp:DropDownList ID="cboArrvDepDt_HH" runat=server>
                                                              <asp:ListItem Text="00" Value="00"></asp:ListItem>
                                                              <asp:ListItem Text="01" Value="01"></asp:ListItem>
                                                              <asp:ListItem Text="02" Value="02"></asp:ListItem>
                                                              <asp:ListItem Text="03" Value="03"></asp:ListItem>
                                                              <asp:ListItem Text="04" Value="04"></asp:ListItem>
                                                              <asp:ListItem Text="05" Value="05"></asp:ListItem>
                                                              <asp:ListItem Text="06" Value="06"></asp:ListItem>
                                                              <asp:ListItem Text="07" Value="07"></asp:ListItem>
                                                              <asp:ListItem Text="08" Value="08"></asp:ListItem>
                                                              <asp:ListItem Text="09" Value="09"></asp:ListItem>
                                                              <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                              <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                             </asp:DropDownList>
                                                             :
                                                             <asp:DropDownList ID="cboArrvDepDt_MM" runat=server>
                                                             <asp:ListItem Text="00" Value="00"></asp:ListItem>
                                                              <asp:ListItem Text="01" Value="01"></asp:ListItem>
                                                              <asp:ListItem Text="02" Value="02"></asp:ListItem>
                                                              <asp:ListItem Text="03" Value="03"></asp:ListItem>
                                                              <asp:ListItem Text="04" Value="04"></asp:ListItem>
                                                              <asp:ListItem Text="05" Value="05"></asp:ListItem>
                                                              <asp:ListItem Text="06" Value="06"></asp:ListItem>
                                                              <asp:ListItem Text="07" Value="07"></asp:ListItem>
                                                              <asp:ListItem Text="08" Value="08"></asp:ListItem>
                                                              <asp:ListItem Text="09" Value="09"></asp:ListItem>
                                                              <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                              <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                              <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                              <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                                              <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                                              <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                                              <asp:ListItem Text="16" Value="16"></asp:ListItem>
                                                              <asp:ListItem Text="17" Value="17"></asp:ListItem>
                                                              <asp:ListItem Text="18" Value="18"></asp:ListItem>
                                                              <asp:ListItem Text="19" Value="19"></asp:ListItem>
                                                              <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                                              <asp:ListItem Text="21" Value="21"></asp:ListItem>
                                                              <asp:ListItem Text="22" Value="22"></asp:ListItem>
                                                              <asp:ListItem Text="23" Value="23"></asp:ListItem>
                                                              <asp:ListItem Text="24" Value="24"></asp:ListItem>
                                                              <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                                              <asp:ListItem Text="26" Value="26"></asp:ListItem>
                                                              <asp:ListItem Text="27" Value="27"></asp:ListItem>
                                                              <asp:ListItem Text="28" Value="28"></asp:ListItem>
                                                              <asp:ListItem Text="29" Value="29"></asp:ListItem>
                                                              <asp:ListItem Text="30" Value="30"></asp:ListItem>
                                                              <asp:ListItem Text="31" Value="31"></asp:ListItem>
                                                              <asp:ListItem Text="32" Value="32"></asp:ListItem>
                                                              <asp:ListItem Text="33" Value="33"></asp:ListItem>
                                                              <asp:ListItem Text="34" Value="34"></asp:ListItem>
                                                              <asp:ListItem Text="35" Value="35"></asp:ListItem>
                                                              <asp:ListItem Text="36" Value="36"></asp:ListItem>
                                                              <asp:ListItem Text="37" Value="37"></asp:ListItem>
                                                              <asp:ListItem Text="38" Value="38"></asp:ListItem>
                                                              <asp:ListItem Text="39" Value="39"></asp:ListItem>
                                                              <asp:ListItem Text="40" Value="40"></asp:ListItem>
                                                              <asp:ListItem Text="41" Value="41"></asp:ListItem>
                                                              <asp:ListItem Text="42" Value="42"></asp:ListItem>
                                                              <asp:ListItem Text="43" Value="43"></asp:ListItem>
                                                              <asp:ListItem Text="44" Value="44"></asp:ListItem>
                                                              <asp:ListItem Text="45" Value="45"></asp:ListItem>
                                                              <asp:ListItem Text="46" Value="46"></asp:ListItem>
                                                              <asp:ListItem Text="47" Value="47"></asp:ListItem>
                                                              <asp:ListItem Text="48" Value="48"></asp:ListItem>
                                                              <asp:ListItem Text="49" Value="49"></asp:ListItem>
                                                              <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                              <asp:ListItem Text="51" Value="51"></asp:ListItem>
                                                              <asp:ListItem Text="52" Value="52"></asp:ListItem>
                                                              <asp:ListItem Text="53" Value="53"></asp:ListItem>
                                                              <asp:ListItem Text="54" Value="54"></asp:ListItem>
                                                              <asp:ListItem Text="55" Value="55"></asp:ListItem>
                                                              <asp:ListItem Text="56" Value="56"></asp:ListItem>
                                                              <asp:ListItem Text="57" Value="57"></asp:ListItem>
                                                              <asp:ListItem Text="58" Value="58"></asp:ListItem>
                                                              <asp:ListItem Text="59" Value="59"></asp:ListItem>
                                                             </asp:DropDownList>
                                                             
                                                              <asp:DropDownList ID="cboArrvDepDt_AMPM" runat=server>
                                                              <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                                                              <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                                                             </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="KM Reading">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtKM_Reading" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqKM_Reading" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKM_Reading"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegKM_Reading" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKM_Reading" Display="Dynamic"></asp:RegularExpressionValidator>

                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                            
                                                             <asp:TemplateColumn HeaderText="KM Travelled">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtKM_Travelled" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqKM_Travelled" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKM_Reading"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegKM_Travelled" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKM_Travelled" Display="Dynamic"></asp:RegularExpressionValidator>

                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                 <asp:TemplateColumn HeaderText="MFST No.">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtMFST_No" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="25"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqMFST_No" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtMFST_No"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn> 
                                                        
                                                        <asp:TemplateColumn HeaderText="Destination">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDestn" runat="server" CssClass="input" Width="50px" BorderStyle="Groove" MaxLength="25"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqDestn" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDestn"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>  
                                                        
                                                        <asp:TemplateColumn HeaderText="Loading Kgs.">
                                                            <ItemTemplate>
                                                               <asp:TextBox ID="txtLoad_Weight" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqLoad_Weight" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtLoad_Weight"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegLoad_Weight" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtLoad_Weight" Display="Dynamic"></asp:RegularExpressionValidator>

                                                             </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>  
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Loading Pkgs">
                                                            <ItemTemplate>
                                                               <asp:TextBox ID="txtLoad_Pkgs" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqLoad_Pkgs" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtLoad_Pkgs"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegLoad_Pkgs" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtLoad_Pkgs" Display="Dynamic"></asp:RegularExpressionValidator>

                                                             </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Unloading Kgs.">
                                                            <ItemTemplate>
                                                               <asp:TextBox ID="txtUnload_Weight" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqUnload_Weight" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtUnload_Weight"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegUnload_Weight" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtUnload_Weight" Display="Dynamic"></asp:RegularExpressionValidator>

                                                             </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>  
                                                 
                                                 
                                                 <asp:TemplateColumn HeaderText="Unloading Pkgs">
                                                            <ItemTemplate>
                                                               <asp:TextBox ID="txtUnload_Pkgs" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqUnload_Pkgs" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtUnload_Pkgs"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegUnload_Pkgs" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtUnload_Pkgs" Display="Dynamic"></asp:RegularExpressionValidator>

                                                             </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>  
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Load Carried in tons">
                                                            <ItemTemplate>
                                                               <asp:TextBox ID="txtLoad_Tons" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqLoad_Tons" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtLoad_Tons"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegLoad_Tons" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtLoad_Tons" Display="Dynamic"></asp:RegularExpressionValidator>

                                                             </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>     
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Reason for delay if any">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDelay_Reason" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>  
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="THC No.">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtTHCno" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqTHCno" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtTHCno"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>  
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Freight Amount">
                                                            <ItemTemplate>
                                                               <asp:TextBox ID="txtFreightAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqFreightAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFreightAmt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegFreightAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtFreightAmt" Display="Dynamic"></asp:RegularExpressionValidator>

                                                             </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>   
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Signature">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSignature" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqSignature" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSignature"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                         </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                                    
                                    
                                    </td>
                                 </tr>
                               </table>  
                </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddRow" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel>                                     
                                                        

                </td>
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan=2>
                   <asp:Button ID="btnSubmit" runat="server" Text="Submit" Font-Bold="true" OnClick="SubmitData"  /> 
                   <%--<asp:Button ID="btnSubmitExpense" runat="server" Text="Submit & Proceed to Expenses >>" Font-Bold="true" OnClick="SubmitExpense" />--%>
                </td>
            </tr>

 </table>
 

 
     
     </p>
     


</asp:Content> 