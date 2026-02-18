```sh
kubectl -n host-access exec -it yoga-root-0 -- chroot /host bash -c "cd ~ && exec bash"
```