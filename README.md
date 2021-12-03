# Destatis Region / Kreise / Gemeinde

Parses the offical document from Destatis and provides convenient Ruby access to all the administrative regions in Germany

Download "Auszug_GV.xlsx" from here: https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ/Archiv/GVAuszugJ/31122020_Auszug_GV.html;jsessionid=014EDECCFE584E09F79555744B3AE367.live721

Parse:

```ruby
parser = Destatis::AuszugGvParser.new("./31122020_Auszug_GV.xlsx")
# might take a couple of seconds
parser.run

# now you have all state regierungsbezirk kreis and gemeinde:

Destatis::State.all
Destatis::Regierungsbezirk.all
Destatis::Kreis.all
Destatis::Gemeinde.all

# and interlinking

Destatis::Gemeinde['Rüsselsheim'].kreis.regierungsbezirk.state == Destatis::State['Hessen']
```

Afterwards you can serialize to json and load on other program runs with improves loading drastically:

```ruby
# once
parser = Destatis::AuszugGvParser.new("./31122020_Auszug_GV.xlsx")
parser.run
Destatis::Loader.save(target = 'GEM_PATH/data/regions.json')


# on each subsequent run:
Destatis::Loader.load(source = 'GEM_PATH/data/regions.json')
```

