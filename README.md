# Destatis Region / Kreise / Gemeinde

Parses the offical document from Destatis and provides convenient Ruby access to all the administrative regions in Germany

Download "Auszug_GV.xlsx" from here: https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ/Archiv/GVAuszugJ/31122020_Auszug_GV.html;jsessionid=014EDECCFE584E09F79555744B3AE367.live721

Parse:

```ruby
parser = Destatus::AuszugGvParser.new("./31122020_Auszug_GV.xlsx")
# might take a couple of seconds
parser.run

# now you have all state regierungsbezirk kreis and gemeinde:

State.all
Regierungsbezirk.all
Kreis.all
Gemeinde.all

# and interlinking

State.first.regierungsbezirke.first.kreise.first.gemeinde.state == State.first
```
