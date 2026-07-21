// SSDT-BATS — stabilize BAT1._BST while AC is connected
//
// Requires ACPI rename: BAT1._BST -> XBST (Count=1)
// When ACAD reports AC present but _BST briefly says discharging,
// SMCBatteryManager treats that as ExternalConnected=No (AC flicker / PowerChime).
// Under Darwin, force charging state so AC stays reported as connected.

DefinitionBlock ("", "SSDT", 2, "ACDT", "BATS", 0x00000000)
{
    External (_SB_.ACAD._PSR, MethodObj)
    External (_SB_.BAT1, DeviceObj)
    External (_SB_.BAT1.XBST, MethodObj)

    Scope (_SB.BAT1)
    {
        Method (_BST, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Local0 = XBST ()
                // If AC adapter present and state is discharging (bit0..2 == 1),
                // force charging (2) to avoid AC disconnect flicker.
                If (\_SB.ACAD._PSR ())
                {
                    If ((DerefOf (Local0 [Zero]) & 0x07) == One)
                    {
                        Local0 [Zero] = 0x02
                    }
                }

                Return (Local0)
            }

            Return (XBST ())
        }
    }
}
