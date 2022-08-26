<%@ Page Language="C#"      MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="TripResult.aspx.cs" Inherits="GUI_Fleet_Reports_TripResult" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
    
    
     <asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Module  > Reports >Journey/Trip Register</asp:Label>
              <%--  <hr align="center" size="1" color="#8ba0e5"> --%>
            </td> 
            
             <td align="right">
             <%--   <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
         
         
          </td>      
        </tr>
    </table>
    
     <hr align="center" size="1" color="#8ba0e5">
      <br/> 
       <br/> 
        <br/> 
        
        
      <table  align="center" cellspacing="1" style="width: 70%">
            <tr align="center">
                <td  align="center">  
                        
                       <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  
                            AutoGenerateColumns="true" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="100"  OnPageIndexChanging="pgChange" OnRowDataBound="GridView1_RowDataBound"  >
                             <Columns >
                              <asp:HyperLinkField Target="_blank"  DataTextField="View Tripsheet" SortExpression="View Tripsheet" HeaderText="View Tripsheet" >
                        <ItemStyle ForeColor="Blue" />
                        <HeaderStyle HorizontalAlign="Center" />
                        <ControlStyle Font-Underline="true" />
                    </asp:HyperLinkField>

                               <%--<asp:TemplateField>
                                    <ItemTemplate>
                                        <div style="color:Blue;font-weight:bold">
                                            <asp:Label ID="Label1" runat="server" Text='<% #DataBinder.Eval(Container.DataItem,"Manual_tripsheetno") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                 </asp:TemplateField>--%>


                                
                            
                             </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView> 
                                                         </ContentTemplate>
                           
                          
                           
                                </asp:UpdatePanel>
                
                </td>
                </tr>
                </table>
                <br/>
                
                
                
                
                 <table align="center" width="70%">
            <tr align="center">
            <td align="center">
			                <input type="button"       value="  XLS  " runat="server" id="btnXML"   onserverclick="btnXML_Click"/>
			  </td>
			          </tr>
			     </table>
                
                   </asp:Content>