# Hides the Windows taskbar (explorer's Shell_TrayWnd windows), or shows it
# again with -Show. GlazeWM runs it from startup_commands / shutdown_commands.
# Keep the taskbar on auto-hide: a hidden taskbar that is not auto-hide still
# reserves its strip of the screen.
param([switch]$Show)

Add-Type @'
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
public static class Taskbar {
    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    static extern IntPtr FindWindowEx(IntPtr parent, IntPtr after, string cls, string title);
    [DllImport("user32.dll")]
    static extern bool ShowWindow(IntPtr hwnd, int cmd);
    [DllImport("user32.dll")]
    static extern uint GetWindowThreadProcessId(IntPtr hwnd, out uint pid);

    // Only explorer's taskbars: yasb also owns a hidden Shell_TrayWnd for its tray.
    static List<IntPtr> Bars() {
        var bars = new List<IntPtr>();
        foreach (string cls in new[] { "Shell_TrayWnd", "Shell_SecondaryTrayWnd" }) {
            IntPtr w = IntPtr.Zero;
            while ((w = FindWindowEx(IntPtr.Zero, w, cls, null)) != IntPtr.Zero) {
                uint pid;
                GetWindowThreadProcessId(w, out pid);
                try {
                    string name = Process.GetProcessById((int)pid).ProcessName;
                    if (string.Equals(name, "explorer", StringComparison.OrdinalIgnoreCase)) bars.Add(w);
                } catch { }
            }
        }
        return bars;
    }

    // Returns how many taskbars it found.
    public static int Show(bool show) {
        List<IntPtr> bars = Bars();
        foreach (IntPtr w in bars) ShowWindow(w, show ? 8 : 0);  // 8 = SW_SHOWNA, 0 = SW_HIDE
        return bars.Count;
    }
}
'@

# Right after logon explorer may not have made the taskbar yet: retry for 10 s.
for ($i = 0; $i -lt 20; $i++) {
    if ([Taskbar]::Show($Show.IsPresent) -gt 0) { break }
    Start-Sleep -Milliseconds 500
}
