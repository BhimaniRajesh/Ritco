<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Loc_Performance_SubRpt.aspx.cs" Inherits="GUI_UNI_MIS_Loc_Performance_Loc_Performance_SubRpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <br />
    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;&nbsp;
    <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" />
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/Loc_Performance/Query.aspx">Location Throughput Performance Report</asp:HyperLink><br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Booking Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                RO</td>
            <td style="width: 343px">
                <asp:Label ID="lblRO" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Booking Location</td>
            <td style="width: 343px">
                <asp:Label ID="lblBookLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
       
    <br />
    <br/>
       <table border="1" style="width: 98%; background-color: #808080" align="center" cellspacing="0" cellpadding="1" class="boxbg" id="Loc_Performance" runat="server">
       <tr><td>
       
        <tr class="bgbluegrey"><td style="width: 5%; height: 25px;"><label class="blackfnt">Sr. No</label></td>
       
        <td><label class="blackfnt"> <%=Session["DocketCalledAs"] %>  number</label></td>
       
        <td><label class="blackfnt">Dely. Location</label></td>
       
        <td><label class="blackfnt">Consignor</label></td>
        
        <td><label class="blackfnt">Consignee</label></td>
        
        <td><label class="blackfnt"> <%=Session["DocketCalledAs"] %>  Date</label></td>
        
        <td><label class="blackfnt"> <%=Session["DocketCalledAs"] %>  Entry. Date</label></td>
        
        <td><label class="blackfnt">Comm. Dely. Date</label></td>
        
        <td><label class="blackfnt">Last Location</label></td>
        
        <td><label class="blackfnt">Dep. Date</label></td>
        
        <td><label class="blackfnt">Current Location</label></td>
        
        <td><label class="blackfnt">Actual Location</label></td>
        
        <td><label class="blackfnt">Pkgs. No.</label></td>
        
        <td><label class="blackfnt">Charge Wt.</label></td>
        
        <td><label class="blackfnt">Arrival Date</label></td>
        
        <td><label class="blackfnt">Dely. Date</label></td>
        
        <td><label class="blackfnt">Diff. hrs</label></td>
                                                        
        </tr>
        
        <asp:Repeater ID="rptBillDetails" runat="server">        
        <ItemTemplate>
        
                <tr style="background-color: White">
                    <td style="width: 198px"><center>
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                        </label></center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label13" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Doc_No")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label1" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Dely_Loc")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label2" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Consignor")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label3" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Consignee")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label4" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Doc_Dt")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label5" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Doc_Entry")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label6" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Comm_Dely")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label7" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Last_Loc")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label8" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Dep_Dt")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label9" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Curr_Loc")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label10" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Actual_Loc")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label11" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Pkg_No")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label12" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Charge")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label14" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Arrival_Dt")%>
                        </label>  </center>
                    </td>
                    <td> <center>                       
                        <label class="blackfnt" id="Label15" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Dely_dt")%>
                        </label>  </center>
                    </td>
                     <td> <center>                       
                        <label class="blackfnt" id="Label16" runat="server">
                            <%#DataBinder.Eval(Container.DataItem, "Diff_Hrs")%>
                        </label>  </center>
                    </td>                        
                </tr>
            </ItemTemplate>
        </asp:Repeater>     
        </td></tr>          
    </table>
    
    <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080" 
                                                                    align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
                                                                    <tr style="background-color: #ffffff">
                                                                        <td colspan="22" align="right" style="width: 892px; height: 23px;">
                                                                            <div align="center">
                                                                                <label style="color: #FF0000;" class="blackfnt">
                                                                                    No Record Found
                                                                                </label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    </table>
    <br />
                                                                    <table border="0" align="center" cellpadding="0" cellspacing="4" 
                                                    id="tblPageNavigation" runat="server">
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                Page&nbsp;
                                                                <asp:Label id="CurrentPage" CssClass="blackfnt" runat="server" />
                                                                &nbsp;of&nbsp;
                                                                <asp:Label id="TotalPages" CssClass="blackfnt" runat="server" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    
                                                  <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" id="FirstPage" Text="[First Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="First" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="PreviousPage" Text="[Previous Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Prev" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="NextPage" Text="[Next Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Next" />    
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="LastPage" Text="[Last Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Last" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                            </label>
                                                            <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)" visible="false">
                                                            </select>
                                                            <input type="hidden" id="HIDCurrentPageNo" runat="server"/>
                                                        </td>
                                                    </tr>
                                                    </table>
                                                    <table width="25%" border="0" cellspacing="1" cellpadding="3" 
                                                        align="center" id="tblButtons" runat="server">
			                                            <tr style="background-color: #ffffff">
			                                                   			                                            
			                                                <td align="center">
                                                                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="DownLoad XLS" /></td>   			                                            
			                                                
			                                            </tr>
		                                            </table> 
</asp:Content>
