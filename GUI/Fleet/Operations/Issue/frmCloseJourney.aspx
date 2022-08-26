<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmCloseJourney.aspx.cs" Inherits="Issue_frmCloseJourney" %>
<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Close Journey</asp:Label>
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
    
    <hr align="center" size="1" color="#8ba0e5" />
      <br> 
      
      
  
      <table cellspacing="1" cellpadding="3" style="width: 95%" align=center class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor=red></asp:Label></td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CLOSE JOURNEY"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Issue Slip Id</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueNo" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>Issue Slip Date</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueDt" runat=server CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            
            <tr style="background-color: white">
                <td colspan=4 align=center>
                <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="100%">
                    <tr bgcolor="white">
                        <td style="height:19px">
                             <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left  ><%--OnItemDataBound="DataGrid1_ItemDataBound"--%>
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                <%--<asp:BoundColumn DataField="RECPT_REF_NO">
                                            <HeaderStyle Width="110px" />
                                 </asp:BoundColumn>--%>
                                        
                                <asp:BoundColumn DataField="Request_Id" HeaderText="Req.ID">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="Request_By" HeaderText="Req. By">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Request_dt" HeaderText="Req. Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Orgn_city" HeaderText="Orign City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Destn_city" HeaderText="Destn. City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="Destn_city" HeaderText="Destn. City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Start_date_time" HeaderText="Start date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="End_dt_tm" HeaderText="End date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="No_Passenger" HeaderText="Passengers">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                  <asp:BoundColumn DataField="Vehtype" HeaderText="Vehicle Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
	                            </Columns>
	                        </asp:datagrid>&nbsp;
	                        <asp:Label ID="lblDataError" runat=server ForeColor=red CssClass="blackfnt"></asp:Label>
		               </td>
                    </tr>
            </table>
         </td>
        </tr> 
        
         <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Vehicle No.</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblVehno" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Driver</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblDriverName" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Driver License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                        <asp:Label ID="lblLicno" runat=server CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:Label ID="lblValidDt" runat=server CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Starting Km. Reading</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblStartKm" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left" >
                  <font class=bluefnt>Closing Km. Reading</font>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtCloseKM" runat=server BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqCloseKM" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegCloseKM" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtCloseKM" Display="Dynamic"></asp:RegularExpressionValidator>

                </td>
                </tr>
                
                
                
                 <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Actual Journey End date & time</font>
                </td>
                <td align="left" colspan=3>
                 <DateCalendar:header id="DtCalEdDt" runat="server"></DateCalendar:header>
                 <asp:DropDownList ID="cboEdDt_HH" runat=server>
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
                 </asp:DropDownList>
                 :
                 <asp:DropDownList ID="cboEdDt_MM" runat=server>
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
                 
                  <asp:DropDownList ID="cboEdDt_AMPM" runat=server>
                  <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                  <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                 </asp:DropDownList>
                </td>
             </tr>   
            
            
               
     </table>
      <p align=center>
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="SubmitData" /></p>
      </p>
     
     


</asp:Content> 