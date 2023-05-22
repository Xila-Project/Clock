import Graphics
import This
import System
import Softwares
import string

#
var Window = This.Get_Window()
var Software = This.Get_This()

var Tabs = Graphics.Tabs_Type()

# - Clock

var Clock_Tab

var Time_Label = Graphics.Label_Type()
var Date_Label = Graphics.Label_Type()

# - Stopwatch

var Stopwatch_Tab

var Stopwatch_Row = Graphics.Object_Type()
var Stopwatch_Time_Label = Graphics.Label_Type()
var Stopwatch_Start_Stop_Button_Label = Graphics.Label_Type()
var Stopwatch_Start_Stop_Button = Graphics.Button_Type()
var Stopwatch_Reset_Button = Graphics.Button_Type()
var Stopwatch_Running = false
var Stopwatch_Start_Time = 0
var Stopwatch_Pause_Time = 0

# - Timer

var Timer_Tab

var Timer_Time_Label = Graphics.Label_Type()

var Timer_First_Row = Graphics.Object_Type()
var Timer_Second_Row = Graphics.Object_Type()

var Timer_Hours_Label = Graphics.Label_Type()
var Timer_Hours_Roller = Graphics.Roller_Type()
var Timer_Minutes_Label = Graphics.Label_Type()
var Timer_Minutes_Roller = Graphics.Roller_Type()
var Timer_Seconds_Label = Graphics.Label_Type()
var Timer_Seconds_Roller = Graphics.Roller_Type()

var Timer_Start_Stop_Button_Label = Graphics.Label_Type()
var Timer_Start_Stop_Button = Graphics.Button_Type()
var Timer_Reset_Button = Graphics.Button_Type()

var Timer_End_Time = 0
var Timer_Pause_Time = 0
var Timer_Running = false

# - Variables

var Continue = true


def Set_Interface_Button(Parent, Button, Text)
    Button.Create(Parent)
    Button.Add_Event(Software, Graphics.Event_Code_Clicked)

    Label = Graphics.Label_Type()
    Label.Create(Button)
    Label.Set_Text(Text)
end

def Set_Interface_Tab(Tab)
    Tab.Set_Flex_Flow(Graphics.Flex_Flow_Column)
    Tab.Set_Flex_Alignment(Graphics.Flex_Alignment_Space_Evenly, Graphics.Flex_Alignment_Center, Graphics.Flex_Alignment_Center)
end

def Set_Interface_Row(Parent, Row)
    Row.Create(Parent)
    Row.Set_Height(Graphics.Size_Content)
    Row.Set_Width(Graphics.Get_Percentage(100))
    Row.Set_Style_Pad_All(0, 0)
    Row.Set_Flex_Flow(Graphics.Flex_Flow_Row)
    Row.Set_Flex_Alignment(Graphics.Flex_Alignment_Space_Evenly, Graphics.Flex_Alignment_Center, Graphics.Flex_Alignment_Center)
end

def Set_Interface_Timer()
    Set_Interface_Tab(Timer_Tab)

    Timer_Time_Label.Create(Timer_Tab)
    Timer_Time_Label.Add_Flag(Graphics.Flag_Hidden)
    Timer_Time_Label.Set_Style_Text_Font(Graphics.Get_Font(34), 0)

    Set_Interface_Row(Timer_Tab, Timer_First_Row)

    Hours_Options = ""

    for i: 0 .. 23
        Hours_Options += str(i) + "\n"
    end


    Timer_Hours_Roller.Create(Timer_First_Row)
    Timer_Hours_Roller.Set_Options(Hours_Options, Graphics.Roller_Mode_Normal)    
    
    Timer_Hours_Label.Create(Timer_First_Row)
    Timer_Hours_Label.Set_Text(":")

    Minutes_Seconds_Options = ""

    for i: 0 .. 59
        Minutes_Seconds_Options += str(i) + "\n"
    end

    Timer_Minutes_Roller.Create(Timer_First_Row)
    Timer_Minutes_Roller.Set_Options(Minutes_Seconds_Options, Graphics.Roller_Mode_Normal)

    Timer_Minutes_Label.Create(Timer_First_Row)
    Timer_Minutes_Label.Set_Text(":")

    Timer_Seconds_Roller.Create(Timer_First_Row)
    Timer_Seconds_Roller.Set_Options(Minutes_Seconds_Options, Graphics.Roller_Mode_Normal)

    Set_Interface_Row(Timer_Tab, Timer_Second_Row)

    Timer_Start_Stop_Button.Create(Timer_Second_Row)
    Timer_Start_Stop_Button.Add_Event(Software, Graphics.Event_Code_Clicked)
    Timer_Start_Stop_Button_Label.Create(Timer_Start_Stop_Button)
    Timer_Start_Stop_Button_Label.Set_Text("Start")

    Set_Interface_Button(Timer_Second_Row, Timer_Reset_Button, "Reset")

end 

def Set_Interface_Stopwatch()
    Set_Interface_Tab(Stopwatch_Tab)

    Stopwatch_Time_Label.Create(Stopwatch_Tab)
    Stopwatch_Time_Label.Set_Text("00:00:00")
    Stopwatch_Time_Label.Set_Style_Text_Font(Graphics.Get_Font(34), 0)

    Set_Interface_Row(Stopwatch_Tab, Stopwatch_Row)

    Stopwatch_Start_Stop_Button.Create(Stopwatch_Row)
    Stopwatch_Start_Stop_Button.Add_Event(Software, Graphics.Event_Code_Clicked)
    Stopwatch_Start_Stop_Button_Label.Create(Stopwatch_Start_Stop_Button)
    Stopwatch_Start_Stop_Button_Label.Set_Text("Start")    

    Set_Interface_Button(Stopwatch_Row, Stopwatch_Reset_Button, "Reset")
end


def Set_Interface_Clock()
    Set_Interface_Tab(Clock_Tab)

    Time_Label.Create(Clock_Tab)
    Time_Label.Set_Text("00:00:00")
    Time_Label.Set_Style_Text_Font(Graphics.Get_Font(34), 0)

    Date_Label.Create(Clock_Tab)
    Date_Label.Set_Text("")
    Date_Label.Set_Style_Text_Font(Graphics.Get_Font(34), 0)
end

def Set_Interface()
    Window.Set_Title("Clock")

    Tabs.Create(Window.Get_Body(), Graphics.Direction_Bottom, 40)
    Tabs.Set_Size(Graphics.Get_Percentage(100), Graphics.Get_Percentage(100))


    Clock_Tab = Tabs.Add_Tab("Clock")
    Set_Interface_Clock()

    Stopwatch_Tab = Tabs.Add_Tab("Stopwatch")
    Set_Interface_Stopwatch()

    Timer_Tab = Tabs.Add_Tab("Timer")
    Set_Interface_Timer()
        
end

def Refresh_Clock()
    # - Time
    Time = System.Get_Time(100)
    Time_String = ""
    if Time.Get_Hours() < 10
        Time_String += "0"
    end
    Time_String += str(Time.Get_Hours())
    Time_String += ":"
    if Time.Get_Minutes() < 10
        Time_String += "0"
    end
    Time_String += str(Time.Get_Minutes()) + ":"
    if Time.Get_Seconds() < 10
        Time_String += "0"
    end
    Time_String += str(Time.Get_Seconds())
    Time_Label.Set_Text(Time_String)

    # - Date

    Date = System.Get_Date()
    Date_String = ""
    Month = Date.Get_Month()
    if Month == 1
        Date_String = "January"
    elif Month == 2
        Date_String = "February"
    elif Month == 3
        Date_String = "March"
    elif Month == 4
        Date_String = "April"
    elif Month == 5
        Date_String = "May"
    elif Month == 6
        Date_String = "June"
    elif Month == 7
        Date_String = "July"
    elif Month == 8
        Date_String = "August"
    elif Month == 9
        Date_String = "September"
    elif Month == 10
        Date_String = "October"
    elif Month == 11
        Date_String = "November"
    elif Month == 12
        Date_String = "December"
    end
    Date_String += " " + str(Date.Get_Day()) + ", " + str(Date.Get_Year())
    Date_Label.Set_Text(Date_String)
end

def Refresh_Stopwatch()
    Time_Elapsed = System.Get_Up_Time_Milliseconds() - Stopwatch_Start_Time
    Time_Elapsed_String = ""
    # - Minutes
    Minutes = Time_Elapsed / (60 * 1000)
    if Minutes < 10
        Time_Elapsed_String = "0"
    end
    # - Seconds
    Time_Elapsed_String += str(Minutes) + ":"
    Seconds = (Time_Elapsed / 1000) % 60
    if Seconds < 10
        Time_Elapsed_String += "0"
    end
    Time_Elapsed_String += str(Seconds) + ":"
    # - Milliseconds
    Milliseconds = (Time_Elapsed / 10) % 100;
    if Milliseconds < 10
        Time_Elapsed_String += "0"
    end   
    Time_Elapsed_String += str(Milliseconds)

    Stopwatch_Time_Label.Set_Text(Time_Elapsed_String)
end

def Refresh_Timer()
    if Timer_End_Time <= System.Get_Up_Time_Milliseconds()
        Timer_Time_Label.Add_Flag(Graphics.Flag_Hidden)
        Timer_First_Row.Clear_Flag(Graphics.Flag_Hidden)
        Timer_End_Time = 0
        Timer_Pause_Time = 0
        Timer_Running = false
        Timer_Start_Stop_Button_Label.Set_Text("Start")
        return
    end

    Remaining_Time = Timer_End_Time - System.Get_Up_Time_Milliseconds()
    Remaining_Time_String = ""
    # - Hours
    Hours = Remaining_Time / (60 * 60 * 1000)
    if Hours < 10
        Remaining_Time_String = "0"
    end
    Remaining_Time_String += str(Hours) + ":"
    # - Minutes
    Minutes = (Remaining_Time / (60 * 1000)) % 60
    if Minutes < 10
        Remaining_Time_String += "0"
    end
    Remaining_Time_String += str(Minutes) + ":"
    # - Seconds
    Seconds = (Remaining_Time / 1000) % 60
    if Seconds < 10
        Remaining_Time_String += "0"
    end
    Remaining_Time_String += str(Seconds)

    Timer_Time_Label.Set_Text(Remaining_Time_String)
end

def Execute_Instruction(Instruction)
    Current_Target = Instruction.Graphics_Get_Current_Target()
    if Instruction.Get_Sender() == Graphics.Get_Pointer()
        if Instruction.Graphics_Get_Code() == Graphics.Event_Code_Clicked
            if Current_Target == Stopwatch_Start_Stop_Button
                if Stopwatch_Running
                    Stopwatch_Running = false
                    Stopwatch_Pause_Time = System.Get_Up_Time_Milliseconds()
                    Stopwatch_Start_Stop_Button_Label.Set_Text("Start")
                    Refresh_Stopwatch()
                else
                    Stopwatch_Running = true
                    Stopwatch_Start_Time += System.Get_Up_Time_Milliseconds() - Stopwatch_Pause_Time
                    Stopwatch_Pause_Time = 0
                    Stopwatch_Start_Stop_Button_Label.Set_Text("Stop")
                end
            elif Current_Target == Stopwatch_Reset_Button
                Stopwatch_Start_Time = 0
                Stopwatch_Pause_Time = 0
                Stopwatch_Running = false
                Stopwatch_Start_Stop_Button_Label.Set_Text("Start")
                Stopwatch_Time_Label.Set_Text("00:00:00")
            elif Current_Target == Timer_Start_Stop_Button
                if Timer_Running
                    Timer_Running = false
                    Timer_Pause_Time = System.Get_Up_Time_Milliseconds()
                    Timer_Start_Stop_Button_Label.Set_Text("Start")
                    Refresh_Timer()
                else
                    Timer_Running = true

                    Timer_Time_Label.Clear_Flag(Graphics.Flag_Hidden)
                    Timer_First_Row.Add_Flag(Graphics.Flag_Hidden)
                    if Timer_Pause_Time == 0
                        Timer_End_Time = Timer_Seconds_Roller.Get_Selected() * 1000
                        Timer_End_Time += Timer_Minutes_Roller.Get_Selected() * 60 * 1000
                        Timer_End_Time += Timer_Hours_Roller.Get_Selected() * 60 * 60 * 1000
                        Timer_End_Time += System.Get_Up_Time_Milliseconds()
                    else
                        Timer_End_Time += System.Get_Up_Time_Milliseconds() - Timer_Pause_Time
                        Timer_Pause_Time = 0
                    end
                    Timer_Start_Stop_Button_Label.Set_Text("Stop")
                end
            elif Current_Target == Timer_Reset_Button
                Timer_Time_Label.Add_Flag(Graphics.Flag_Hidden)
                Timer_First_Row.Clear_Flag(Graphics.Flag_Hidden)
                Timer_End_Time = 0
                Timer_Pause_Time = 0
                Timer_Running = false
                Timer_Start_Stop_Button_Label.Set_Text("Start")
            end
        end
    elif Instruction.Get_Sender() == Softwares.Get_Pointer()
        if Instruction.Softwares_Get_Code() == Softwares.Event_Code_Cose
            Continue = false
        end 
    end
end


Set_Interface()

while Continue

    if This.Instruction_Available() > 0
        Execute_Instruction(This.Get_Instruction())
    end

    # Clock
    if Tabs.Get_Tab_Active() == 0
        Refresh_Clock()
    # Stopwatch
    elif (Tabs.Get_Tab_Active() == 1) && Stopwatch_Running
        Refresh_Stopwatch()
    # Timer
    elif (Tabs.Get_Tab_Active() == 2) && Timer_Running
        Refresh_Timer()
    end  

    This.Delay(50)

end