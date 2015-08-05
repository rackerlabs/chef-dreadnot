# dreadnot-cookbook

This is a chef cookbook to isntall and configure [Dreadnot]() deploy software.

## Supported Platforms

* Ubuntu 14.04 LTS

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['dreadnot']['user']</tt></td>
    <td>String</td>
    <td>User to run as and own files</td>
    <td><tt>dreadnot</tt></td>
  </tr>
  <tr>
    <td><tt>['dreadnot']['group']</tt></td>
    <td>String</td>
    <td>Group to own files</td>
    <td><tt>dreadnot</tt></td>
  </tr>
  <tr>
    <td><tt>['dreadnot']['dir']</tt></td>
    <td>String</td>
    <td>Directory</td>
    <td><tt>/opt/dreadnot</tt></td>
  </tr>
  <tr>
    <td><tt>['dreadnot']['config']</tt></td>
    <td>String</td>
    <td>Path to configuration file</td>
    <td><tt>/opt/dreadnot/settings.js</tt></td>
  </tr>
  <tr>
    <td><tt>['dreadnot']['domain']</tt></td>
    <td>String</td>
    <td>Domain name to use for the webhost</td>
    <td><tt>dreadnot.example.com</tt></td>
  </tr>
</table>

## Usage

### dreadnot::default

Include `dreadnot` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[dreadnot::default]"
  ]
}
```

## License and Authors

Author:: Michael Burns (<michael.burns@rackspace.com>)

Author:: Rackspace (<ele-ops@lists.rackspace.com>)
