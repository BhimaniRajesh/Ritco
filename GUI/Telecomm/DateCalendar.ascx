<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateCalendar.ascx.cs" Inherits="DateCalendar" %>

<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="atlasToolkit" %>

                    
                     <asp:TextBox ID="useDateCal" runat="server" Width="74px" BorderStyle="Groove" ></asp:TextBox><asp:RegularExpressionValidator ID="REVSalesDt" runat="server" ControlToValidate="useDateCal"
                        ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                        Width="1px"></asp:RegularExpressionValidator>
                    
 
            <asp:Panel ID="Panel1" runat="server" CssClass="popupControl">
                
            <atlas:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <center>

                <atlasToolkit:PopupControlExtender ID="PopupControlExtender1" runat="server">
                    <atlasToolkit:PopupControlProperties TargetControlID="useDateCal" PopupControlID="Panel1" Position="Bottom" />
                </atlasToolkit:PopupControlExtender>
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#999999" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Width="160px" OnSelectionChanged="Calendar1_SelectionChanged">
                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <SelectorStyle BackColor="#CCCCCC" />
                        <WeekendDayStyle BackColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#808080" />
                        <NextPrevStyle VerticalAlign="Bottom" />
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                    </asp:Calendar>
                    &nbsp;</center>

            </ContentTemplate>
        </atlas:UpdatePanel>
    </asp:Panel>