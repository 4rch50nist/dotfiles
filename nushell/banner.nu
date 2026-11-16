# --- data sources --------------------------------------------------------
let weather_url = "https://wttr.in/Kolkata?format=j1"
let gh_url      = "https://api.github.com/users/adityavikramsinha/events"

# token is optional: without it you just get GitHub's lower rate limit
let github_token = $env.github_terminal_view_api_token? | default ""
let gh_headers = if ($github_token | is-empty) { [] } else { [Authorization $"token ($github_token)"] }

# parallel, but --keep-order so index 0/1/2 always match these closures
let results = [
    { try { http get --raw $weather_url | from json } catch { null } }
    { try { http get --headers $gh_headers $gh_url } catch { [] } }
    { try {
        system_profiler SPAirPortDataType
        | lines
        | where $it =~ 'Transmit Rate'
        | first
        | split row ':'
        | last
        | str trim
      } catch { "?" } }
] | par-each --keep-order {|job| do $job }

# --- weather (wttr.in) ---------------------------------------------------
let current_weather = $results.0 | get current_condition?.0? | default {}
let temperature = $current_weather.temp_C? | default "?"
let app_temp    = $current_weather.FeelsLikeC? | default "?"
let wind_speed  = $current_weather.windspeedKmph? | default "?"
let rain        = $current_weather.precipMM? | default "?"
let temp_num    = try { $temperature | into int } catch { 0 }
let temperature_glyph = if $temp_num >= 30 { "☀️" } else { "🍃" }

# --- github / system -----------------------------------------------------
let commit_count = $results.1 | length
let network_in_mbps = $results.2

let mem = sys mem
let mem_pct = ($mem.used / $mem.total * 100 | into int)
let host = sys host

# I don't like it being this close to terminal, sorry.
let space = "            "

# --- banner --------------------------------------------------------------
let welcome = $"




($space) █████╗ ██╗   ██╗███████╗                 ($commit_count)
($space)██╔══██╗██║   ██║██╔════╝               ⾕ ($host.hostname)
($space)███████║██║   ██║███████╗               ↑⇣ ($host.uptime)
($space)██╔══██║╚██╗ ██╔╝╚════██║               ⛁  ($mem.used) / ($mem.total) [($mem_pct)%]
($space)██║  ██║ ╚████╔╝ ███████║               ᯤ  ($network_in_mbps) Mbps
($space)╚═╝  ╚═╝  ╚═══╝  ╚══════╝               ($temperature_glyph) ($temperature)°C[($app_temp)] | ≈ ($wind_speed) km/h | ☔ ($rain)mm





"

let gradient = $welcome | ansi gradient --fgstart '0xF9E2AF' --fgend '0xd158d1'
print $gradient
