```sh
kubectl -n host-access exec -it sus-root-0 -- chroot /host bash -c "cd ~ && exec bash"
```
