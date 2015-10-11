# PowerSpec

### Environment Spec Check made easy with powershell!

PowerSpec is a lightweight library of powershell scripts for testing machine configuration via powershell. If you need to validate a server's base configuration, use PowerSpec to declare all of the settings needed for a successful deploy from CI to PreProduction to Production.

## Contributing to PowerSpec

Contributions are encouraged, but users would be even better!

Things I would like help with:
 - Rules. These are some base rules I need in my organization. If you write your own and they fit the library, I'll happily merge them!
 - Documentation. I don't have much, and I'm vain enough that I don't think its necessary. But if you're the kind who would prefer the "IsInstalled" function had some documentation, please feel free!

## RoadMap
More rules!

## Documentation

An example spec is included in the library. Import PowerSpec.ps1, use addSpec(rule) to define the contract, then call checkSpec to find out if everything is set up correctly.